package model;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.RequestMapping;
import dao.UserDAO;
import vo.UserVO;

public class MyPageModel {
	
	@RequestMapping("my/myPage.do")
	public String myPage(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getUserData(userId);
		
		request.setAttribute("vo", vo);
		request.setAttribute("mainMy_jsp", "../my/myPage.jsp");
		request.setAttribute("main_jsp", "../my/mainMy.jsp");
		return "../main/main.jsp";
	}
	
	
	@RequestMapping("my/myPage_update.do")
	public String myPageUpdateData(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getUserData(userId);
		request.setAttribute("vo", vo);
		return "../my/myPageUpdate.jsp";
	}
	
	
	@RequestMapping("my/myPageUpdate_ok.do")
	public String myPageUpdate(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			request.setCharacterEncoding("UTF-8");
		}catch(Exception e) {
			e.printStackTrace();
		}
		   // 입력값 받기 
		   String id=(String) session.getAttribute("userId");
		   String name=request.getParameter("name");
		   String gender=request.getParameter("gender");
		   String birth=request.getParameter("birth");
		   String email=request.getParameter("email");
		   String post=request.getParameter("post");
		   String address1=request.getParameter("address1");
		   String address2=request.getParameter("address2");
		   String tel=request.getParameter("tel");
		   String content=request.getParameter("content");
		   
		   UserVO vo=new UserVO();
		   vo.setId(id);
		   vo.setName(name);
		   vo.setGender(gender);
		   vo.setBirth(birth);
		   vo.setEmail(email);
		   vo.setPost(Integer.parseInt(post));
		   vo.setAddress1(address1);
		   if(address2==null)
			   address2="";
		   vo.setAddress2(address2);
		   tel = tel.replace("-", "");
		   vo.setTel(Integer.parseInt(tel));
		   vo.setContent(content);
		
		   	UserDAO dao = new UserDAO();
		   	dao.UserUpdate(vo);
		return "redirect:../my/myPage.do";
	}
	@RequestMapping("my/myPage_delete.do")
	public String myPageDeleteData(HttpServletRequest request,HttpServletResponse response) {
		
		return "../my/myPageDelete.jsp";
	}
	
	@RequestMapping("my/myPageDelete_ok.do")
	public String myPageDeleteOK(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		Cookie[] cookies= request.getCookies();
		String userId = (String) session.getAttribute("userId");
		String pwd = request.getParameter("pwd");
		UserDAO dao = new UserDAO();
		String result = dao.UserDelete(pwd, userId);
		if(result.equals("Y")) {
			for(int i=0;i<cookies.length;i++) {
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
			}
			session.invalidate();
		}
		request.setAttribute("result", result);
		return "../my/myPagePwd.jsp";
		
	}
/* =============================================== 어드민 페이지 ======================================================	*/
	
	@RequestMapping("my/adminPage.do")
	public String adminPage(HttpServletRequest request,HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../my/adminPage.jsp");
		return "../main/main.jsp";
	}
}
