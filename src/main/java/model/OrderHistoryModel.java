package model;

import java.util.*;
import dao.*;
import vo.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import controller.RequestMapping;

public class OrderHistoryModel {
	
	//주문내역으로 가기 클릭시 
	@RequestMapping("my/orderHistory.do")
	public String orderHistory(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession session=request.getSession();
	    String user_id= session.getAttribute("userId").toString();
		String page=request.getParameter("page");
		//list용
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		OrderHistoryDAO ohdao=new OrderHistoryDAO();
		List<OrderHistoryVO> ohList=ohdao.orderHistoryListData(curpage,user_id);
		int totalpage=ohdao.orderHistoryTotalPage(user_id);
		
		//list용
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("ohList", ohList);
		
		request.setAttribute("mainMy_jsp", "../my/orderHistory.jsp");
		request.setAttribute("pageName", "My 주문내역");
		request.setAttribute("main_jsp", "../my/mainMy.jsp");
		return "../main/main.jsp";
	}
	
	//주문내역 리스트의 '주문번호' 클릭시  //detail항목 hide()/show() 처리
	@RequestMapping("my/orderHistory_detail.do")
	public String orderHistory_detail(HttpServletRequest request,
			HttpServletResponse response) {
		
		int order_id=Integer.parseInt(request.getParameter("order_id"));
		
		OrderHistoryDAO ohdao=new OrderHistoryDAO();
		List<OrderHistoryVO> ohList=ohdao.OrderHistoryDetail( order_id);
		
		request.setAttribute("ohDetailList", ohList);
		
		return " ";// 주문내역리스트의 '주문번호' 클릭시 디테일정보 show...
		//원래있던페이지에 돌아가면 show상태 가능한가..? ajax필요?
		
	}
	
	//삭제버튼 클릭시
	@RequestMapping("my/orderHistory_delete.do")
	public String orderHistory_delete(HttpServletRequest request,
			HttpServletResponse response) {
		
		String order_id=request.getParameter("order_id");
		
		OrderHistoryDAO dao=new OrderHistoryDAO();
		dao.orderHistory_delete(Integer.parseInt(order_id));
		
		return "redirect:../my/orderHistory.do";//삭제작업만 한 후 다시 있던페이지로 되돌아가기
	}
	
		  
}

