package model;

import java.util.*;
import dao.*;
import vo.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;

public class OrderHistoryModel {
	
	//주문내역으로 가기 클릭시 // detail항목은 페이지따로 두지 않고 hide()/show() 처리..
	@RequestMapping("my/orderHistory.do")
	public String orderHistory(HttpServletRequest request,
			HttpServletResponse response) {
		String order_id=request.getParameter("order_id");
		String page=request.getParameter("page");
		//list용
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		OrderHistoryDAO ohdao=new OrderHistoryDAO();
		List<PayVO> list=ohdao.orderHistoryListData(curpage);
		int totalpage=ohdao.orderHistoryTotalPage();
		
		//detail용
		PayVO pvo=ohdao.OrderHistoryDetail(Integer.parseInt(order_id));//해당 주문번호를 가지고 있는 pvo객체
		BookDAO bookdao=new BookDAO();
		String bid=Integer.toString(pvo.getBook_id());//pvo의 bookID로 상품디테일정보 get!
		BookVO bvo=bookdao.findBook(bid);//해당 책
		
		//list용
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("list", list);//
		
		//detail용
		//detail_주문/결제 정보 VO
		request.setAttribute("pvo", pvo);
		//detail_책 정보
		request.setAttribute("name", bvo.getName());
		request.setAttribute("poster", bvo.getPoster());		
		request.setAttribute("author", bvo.getAuthor());
		
		
		
		request.setAttribute("mainMy_jsp", "../my/orderHistory.jsp");
		request.setAttribute("pageName", "My 주문내역");
		request.setAttribute("main_jsp", "../my/mainMy.jsp");
		return "../main/main.jsp";
	}
	
	//삭제버튼 클릭시
	@RequestMapping("my/orderHistory_delete.do")
	public String orderHistory_delete(HttpServletRequest request,
			HttpServletResponse response) {
		String order_id=request.getParameter("order_id");
		
		OrderHistoryDAO dao=new OrderHistoryDAO();
		dao.orderHistory_delete(Integer.parseInt(order_id));
		
		return "redirect:../my/orderHistory.do";
	}
	
	
		
		  
		  
}

