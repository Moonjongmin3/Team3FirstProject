package model;

import dao.*;
import vo.*;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import controller.RequestMapping;

public class PayModel {
   
   @RequestMapping("pay/order.do")//바로구매 클릭시
   public String order_info(HttpServletRequest request,
         HttpServletResponse response) {	   
	   
      HttpSession session=request.getSession();
      String id=(String)session.getAttribute("userId");//user_id
      String bid=request.getParameter("no");//book_id 'bid'로 받고
      String quantity=request.getParameter("qty");// bookList_qty
      int qty=Integer.parseInt(quantity); 
     
      PayDAO dao=new PayDAO();
      UserVO uvo=dao.orderer_info(id);//배송정보
      BookVO bvo=dao.book_info(Integer.parseInt(bid));//상품정보     
      
      //배송정보
      request.setAttribute("userName", uvo.getName());
      request.setAttribute("userPhone", uvo.getTel());
      request.setAttribute("userEmail", uvo.getEmail());
      request.setAttribute("userAddr1", uvo.getAddress1());
      request.setAttribute("userAddr1", uvo.getAddress2());
      //request.setAttribute("userPoint", uvo.getPoint());// UserVO에 point 없음
      
      //주문상품
      request.setAttribute("poster", bvo.getPoster());
      request.setAttribute("mainCategory", bvo.getMainCategory());
      request.setAttribute("title", bvo.getName());
      request.setAttribute("author", bvo.getAuthor());
      request.setAttribute("price", bvo.getPrice());//정가
      request.setAttribute("saleRate", bvo.getSaleRate());
      request.setAttribute("point", bvo.getPrice()*0.05);//적립포인트
      request.setAttribute("qty", qty);
      //배송예정일자:주문 후 2일 이후
      request.setAttribute("diliveryDate",new Date(new Date().getTime() + 60*60*24*1000*2));
      request.setAttribute("sellingPrice", bvo.getPrice()*(1.0-(bvo.getSaleRate()/100)));//판매가
      
      request.setAttribute("main_jsp","../pay/pay.jsp");
      return "../main/main.jsp";
   }
   
   //"주문내역으로 가기" 클릭시
   @RequestMapping("my/orderHistory.do")//바로구매 클릭시
   public String orderHistory(HttpServletRequest request,
         HttpServletResponse response) {
	   //
	   return "../main/main.jsp";
   }
   
   //"메인으로 이동" 클릭시
   @RequestMapping("main/main.do")//바로구매 클릭시
   public String main(HttpServletRequest request,
         HttpServletResponse response) {
	   
	   return "redirect:../main/main.do";// ??
   }

}