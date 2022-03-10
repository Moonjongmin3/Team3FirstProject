package model;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.RequestMapping;
import dao.LoginDAO;
import vo.UserVO;


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
			UserVO vo = dao.isLogin(id, pwd);
			request.setAttribute("result",vo);

			String result = vo.getMsg();
			if(!(result.equals("NOID")||result.equals("NOPWD"))){

				session.setAttribute("userName",vo.getName());
				String admin_check=vo.getAdmin();
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
	   // 회원 가입 처리 ==> 요청 처리 => 화면 이동 
	   @RequestMapping("user/join_ok.do")
	   public String memberJoinOk(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   try
		   {
			   request.setCharacterEncoding("UTF-8");
			   // 입력값 받기 
			   String id=request.getParameter("id");
			   String password=request.getParameter("pwd");
			   String name=request.getParameter("name");
			   String gender=request.getParameter("gender");
			   String birth=request.getParameter("birth");
			   String email=request.getParameter("email");
			   String post=request.getParameter("post");
			   String address1=request.getParameter("address1");
			   String address2=request.getParameter("address2");
			   String tel=request.getParameter("tel");
			   String content=request.getParameter("content");
	
			   // MemberDAO로 전송 ==> 오라클 Insert
			   UserVO vo=new UserVO();
			   vo.setId(id);
			   vo.setPassword(password);
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
	
			   LoginDAO dao=new LoginDAO();
			   //메소드 (INSERT)
			   dao.memberJoin(vo);
		   }catch(Exception ex){
			   	ex.printStackTrace();
		   }
		   return "redirect:../main/main.do";
	   }
	@RequestMapping("user/idcheck.do")
    public String memberIdCheck(HttpServletRequest request, HttpServletResponse respose) {
    	
    	return"../user/idcheck.jsp";
    }
	@RequestMapping("user/idfind_result.do")
    public String memberIdCFind_Result(HttpServletRequest request, HttpServletResponse respose) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    String name = request.getParameter("member_name");
	     String tel = request.getParameter("member_tel");
	     
	     LoginDAO dao = new LoginDAO();
	     String id = dao.findId_tel(name, tel); 	
	     
	     request.setAttribute("id", id);
	     request.setAttribute("main_jsp", "../user/idfind_result.jsp");
	     
    	return"../main/main.jsp";
    }
	@RequestMapping("user/idfind.do")
    public String memberIdFind(HttpServletRequest request, HttpServletResponse respose) {
    	
    	return"../user/idfind.jsp";
    }
	@RequestMapping("user/pwdfind.do")
	public String memberPwdFind(HttpServletRequest request, HttpServletResponse respose) {
		
		return"../user/pwdfind.jsp";
	}
}
