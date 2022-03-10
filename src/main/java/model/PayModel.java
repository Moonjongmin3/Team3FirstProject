package model;

import dao.*;
import vo.*;

import java.io.FileReader;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import controller.RequestMapping;

public class PayModel {
   
   @RequestMapping("pay/order.do")//바로구매 클릭시//book_list, detail 페이지 연결
   public String order_info(HttpServletRequest request,
         HttpServletResponse response) {	   
	   
      HttpSession session=request.getSession();
      String id=(String)session.getAttribute("userId");//user_id
      String bid=request.getParameter("no");//book_id 'bid'로 받고
      String qty=request.getParameter("qty");// bookList_qty
      int quantity=Integer.parseInt(qty); 
     
      PayDAO dao=new PayDAO();//주문자정보 찾기용
      BookDAO bDao=new BookDAO();//상품정보 찾기용
      UserVO uvo=dao.orderer_info(id);//배송정보
//      BookVO bvo=dao.book_info(Integer.parseInt(bid));//상품정보    
      List<BookVO> orderBookList=new ArrayList<BookVO>(); 
      BookVO bvo=bDao.findBook(bid);
      orderBookList.add(bvo);
           
      
      
      request.setAttribute("orderBookList", orderBookList);//주문상품
      request.setAttribute("diliveryDate",new Date(new Date().getTime()+60*60*24*1000*2));
      //배송정보
      request.setAttribute("uvo", uvo);

      
      request.setAttribute("main_jsp","../pay/pay.jsp");
      return "../main/main.jsp";
   }
   
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
   @RequestMapping("pay/order_insert.do")
   public String order_insert(HttpServletRequest request,
	         HttpServletResponse response) {	   
		   
	      HttpSession session=request.getSession();
	      String id=(String)session.getAttribute("userId");//user_id
//	      String bid=request.getParameter("book_id");//book_id 'bid'로 받고
//	      String quantity=request.getParameter("qty");// bookList_qty
//	      int qty=Integer.parseInt(quantity); 
	     
	     
//	      String[] orderobj= {
//	    		  request.getParameter("receiver_name"),//0
//	    	      
//	    	      request.getParameter("ship_address1"),//1
//	    	      request.getParameter("ship_address2"),//2
//	    	      request.getParameter("zipcode"),//3
//	    	      
//	    	      request.getParameter("receiver_phone1"),//4
//	    	      request.getParameter("receiver_phone2"),//5
//	    	      request.getParameter("receiver_phone3"),//6
//	    	      
//	    	      request.getParameter("ship_request"),//7
////	    	      request.getParameter("use_point");
//	    	      request.getParameter("total_price")//8
//	     };
	      
	      Date today = new Date();
	      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	      String today_str = sdf.format(today); 
	      	      
	      String receiver_name=request.getParameter("receiver_name");//0
	    	      
	      String ship_address1=request.getParameter("ship_address1");//1
	      String ship_address2=request.getParameter("ship_address2");//2
	      String zipcode=request.getParameter("zipcode");//3
	    	      
	      String receiver_phone1=request.getParameter("receiver_phone1");//4
	      String receiver_phone2=request.getParameter("receiver_phone2");//5
	      String receiver_phone3=request.getParameter("receiver_phone3");//6
	      int receiver_phone=Integer.parseInt(receiver_phone1+receiver_phone2+receiver_phone3);
	      
//	      String order_id=today_str+receiver_phone2+receiver_phone3;//주문일+폰번호..ㅎ
	      
	      String ship_request=request.getParameter("ship_request");
	      if(ship_request==null)
	    	  ship_request="내용없음";
//	      String receiver_name=request.getParameter("use_point");
	      String total_price=request.getParameter("total_price");//8
	      //
	      String book_id=request.getParameter("book_id");
	      String order_poster=request.getParameter("order_poster");
	      String category_name=request.getParameter("category_name");
	      String quantity=request.getParameter("quantity");
	      
	     OrderHistoryVO ohvo=new OrderHistoryVO(); // 주문내역 데이터 
//	     ohvo.setOrder_id(Integer.parseInt(order_id));
	     ohvo.setBook_id(Integer.parseInt(book_id));
	     ohvo.setUser_id(id);
	     ohvo.setReceiver_name(receiver_name);
	     ohvo.setShip_address1(ship_address1);
	     ohvo.setShip_address2(ship_address2);
	     ohvo.setZipcode(zipcode);
	     ohvo.setReceiver_phone(receiver_phone);
	     ohvo.setShip_request(ship_request);
	     ohvo.setState("주문완료");//주문완료/취소
	     ohvo.setPay_state(0);//결제대기/완료
	     ohvo.setOrder_date(today);
	     ohvo.setTotal_price(Integer.parseInt(total_price));
	     ohvo.setQuantity(Integer.parseInt(quantity));
	     ohvo.setPoster(order_poster);
	     ohvo.setCate_name(category_name);
	      
	      PayDAO dao=new PayDAO();
	      dao.orders_insert(ohvo);//주문정보 오라클에 insert
	      dao.order_item_insert(ohvo);
	     
	     
//	      request.setAttribute("order_id", ohvo.getOrder_id());
//	      request.setAttribute("main_jsp","../pay/order_complete.jsp");
//	      request.setAttribute("main_jsp","../pay/pay.jsp");
	      return "../my/orderHistory.do";// 마이페이지로 이동
   }		//주문정보 인서트 작업한 후 '주문내역페이지로 이동'



}