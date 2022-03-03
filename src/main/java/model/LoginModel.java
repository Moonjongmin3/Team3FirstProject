package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.RequestMapping;
import dao.BookDAO;
import dao.LoginDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

public class LoginModel {
	
	@RequestMapping("user/login.do")
	public String login_main(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId=(String)session.getAttribute("userId");
		if(userId!=null)
			return "redirect:../main/main.do";
		request.setAttribute("main_jsp", "../user/login.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("user/login_ok.do")
	public String login_check(HttpServletRequest request,HttpServletResponse response){
		try {
			HttpSession session= request.getSession();
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String check = request.getParameter("check");
			LoginDAO dao = new LoginDAO();
			// UserVO로 결과값을 받을지 고민
			String result = dao.isLogin(id, pwd);
			request.setAttribute("result",result);
			if(!(result.equals("NOID")||result.equals("NOPWD"))){
				StringTokenizer st = new StringTokenizer(result, "|");

				session.setAttribute("userName",st.nextToken());
				String admin_check=st.nextToken();
				if(admin_check.equals("N")){
					session.setAttribute("admin",0);
				}else {
					session.setAttribute("admin",1);
				}
				session.setAttribute("login", 1);
				session.setAttribute("userId",id);
			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return "../user/login_ok.jsp";
	}

	@RequestMapping("user/logout.do")
	public String logout(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userId");
		LoginDAO dao = new LoginDAO();
		dao.logout(id);

		session.invalidate();
		return "redirect:../main/main.do";
	}
	@RequestMapping("user/join.do")
    public String memberJoin(HttpServletRequest request,HttpServletResponse response){
	    request.setAttribute("main_jsp", "../user/join.jsp");
        return "../main/main.jsp";
	   }
	@RequestMapping("user/idcheck.do")
    public String memberIdCheck(HttpServletRequest request, HttpServletResponse respose) {
    	
    	return"../user/idcheck.jsp";
    }
}
