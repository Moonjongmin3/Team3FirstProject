package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;

public class MyPageModel {
	
	@RequestMapping("my/myPage.do")
	public String myPage(HttpServletRequest request,HttpServletResponse response) {
		
		
		
		request.setAttribute("mainMy_jsp", "../my/myPage.jsp");
		request.setAttribute("main_jsp", "../my/mainMy.jsp");
		return "../main/main.jsp";
	}
}
