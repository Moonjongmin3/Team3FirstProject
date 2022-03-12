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
	   String userId=(String)session.getAttribute("userId");//user_id
	   
	   String orderJson = request.getParameter("payInfo");
	   String books = request.getParameter("books");
	   String qtys = request.getParameter("qtys");
		  
	   Gson gson = new GsonBuilder().setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
			   .create();
	   PayVO payInfo = gson.fromJson(orderJson, PayVO.class);
	   
	   System.out.println(payInfo.getBuyerName());
	   InstanceConverter ic = new InstanceConverter();
	   OrderHistoryVO order = ic.converToOHVO(payInfo, userId);
		  
	   PayDAO payDAO = new PayDAO();
	   payDAO.orders_insert(order);

       request.setAttribute("main_jsp","../pay/order_complete.jsp");
       return "../main/main.jsp";
   }
}