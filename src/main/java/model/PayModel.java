package model;

import dao.*;
import vo.*;

import java.io.FileReader;
import java.io.Reader;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import Common.InstanceConverter;
import controller.RequestMapping;

public class PayModel {
   
   @RequestMapping("pay/orderlist.do")//cart 페이지 연결
   public String orderlist_info(HttpServletRequest request,
         HttpServletResponse response) {	   
	   
      HttpSession session=request.getSession();
      String id=(String)session.getAttribute("userId");//user_id
      //Gson books
      String books = request.getParameter("books");//Gson books=[{id:qty}, ..]      
      Gson gson = new Gson();
      
      List<BookVO> orderBookList = gson.fromJson(books, new TypeToken<List<BookVO>>(){}.getType());
      
      PayDAO pdao=new PayDAO();
     
      //상품정보
      UserVO uvo=pdao.orderer_info(id);//배송정보
      request.setAttribute("orderBookList",orderBookList );
      //request.setAttribute("diliveryDate",new Date().getTime() + 60*60*24*1000*2);
      //배송정보
     
      request.setAttribute("uvo", uvo);
      request.setAttribute("main_jsp","../pay/pay.jsp");
      return "../main/main.jsp";
      
   }
   
   //insert
   @RequestMapping("pay/order_ok.do")
   public String orderOk(HttpServletRequest request, HttpServletResponse response) {	   
	   HttpSession session=request.getSession();
	   String userId=(String)session.getAttribute("userId");
	   String orderJson = request.getParameter("payInfo");
	   String[] books = request.getParameter("books").substring(1).split(",");
	   String[] qtys = request.getParameter("qtys").substring(1).split(",");
	   // 아임포트 결제 정보 JSON 역직렬화
	   Gson gson = new GsonBuilder().setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
			   .create();
	   PayVO payInfo = gson.fromJson(orderJson, PayVO.class);
	   // 결제 정보 객체와 주문 내역 객체 매핑
	   InstanceConverter ic = new InstanceConverter();
	   OrderHistoryVO order = ic.converToOHVO(payInfo, userId);
	   // 주문 내역 DB 저장
	   PayDAO payDAO = new PayDAO();
	   payDAO.orders_insert(order);
	   // 주문 상품 DB 저장
	   for (int i = 0; i < qtys.length; i++) {
		   OrderItemVO item = new OrderItemVO(order.getOrder_id(), Integer.parseInt(books[i]), Integer.parseInt(qtys[i]));
		   payDAO.insertOrderItem(item);
	   }
	   // 결제한 상품 장바구니에서 제거
	   CartDAO cartDAO = new CartDAO();
	   for(String bookId : books) {
			cartDAO.deleteCart(Integer.parseInt(bookId), userId);
		}
       request.setAttribute("main_jsp","../pay/order_complete.jsp");
       return "../main/main.jsp";
   }
}