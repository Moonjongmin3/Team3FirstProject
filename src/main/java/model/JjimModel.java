package model;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.RequestMapping;
import dao.BookDAO;
import vo.BookVO;

public class JjimModel {
	@RequestMapping("my/Jjim.do")
	public String Jjim(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		HttpSession session=request.getSession();
		String uer_id=(String)session.getAttribute("user_id");
		String board_id=(String)request.getParameter("board_id");
		
		BookVO vo=new BookVO();

		request.setAttribute("no",no);
		request.setAttribute("uer_id",uer_id);
		request.setAttribute("uer_id",board_id);
		request.setAttribute("vo",vo);
		request.setAttribute("main_jsp", "../my/Jjim.jsp");
		
		return "..main/main.do";
	}

}
