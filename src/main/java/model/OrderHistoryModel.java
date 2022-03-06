package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;

public class OrderHistoryModel {
	@RequestMapping("my/orderHistory.do")
	public String orderHistory(HttpServletRequest request,
			HttpServletResponse response) {
		
		request.setAttribute("mainMy_jsp", "../my/orderHistory.jsp");//??
		request.setAttribute("pageName", "My 주문내역");
		request.setAttribute("main_jsp", "../my/mainMy.jsp");
		return "../main/main.jsp";
	}
	
}
