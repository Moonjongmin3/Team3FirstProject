package model;

import java.util.*;
import dao.BoardDAO;
import vo.BoardVO;
import model.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.RequestMapping;


public class BoardModel {
	@RequestMapping("board/list.do")
	public String boardList(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			String page=request.getParameter("page");
			if(page==null) {
				page="1";
			}
			int curpage=Integer.parseInt(page);
			int block=5;
			int startpage=((curpage-1)/block*block)+1;
			int endpage=startpage-1+block;
			
			BoardDAO dao=new BoardDAO();
			int totalpage=dao.boardTotalPage();
			if(endpage>totalpage) {
				endpage=totalpage;
			}
			
			List<BoardVO> list=dao.boardList(curpage);
			request.setAttribute("cutpage", curpage);
			request.setAttribute("totalpage", totalpage);
			request.setAttribute("board_list", list);
			request.setAttribute("startpage", startpage);
			request.setAttribute("endpage", endpage);
			request.setAttribute("main_jsp", "../board/list.jsp");
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/board_detail.do")
	public String boardDetailData(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		String page=request.getParameter("page");
		
		BoardDAO dao=new BoardDAO();
		BoardVO vo=dao.boardDetailData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		request.setAttribute("page", page);
		request.setAttribute("main_jsp", "../board/board_detail.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/board_insert.do")
	public String boardInsert(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../board/board_insert.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/board_insert_ok.do")
    public String boardInsert_ok(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            String userID = request.getParameter("userID");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
    	    String pwd = request.getParameter("pwd");
           
            BoardVO vo = new BoardVO();
            vo.setUser_id(userID);
            vo.setTitle(title);
            vo.setContent(content);
            vo.setPwd(pwd);
            BoardDAO dao = new BoardDAO();
            dao.boardInsert(vo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:../board/list.do";
    }
	
	@RequestMapping("board/board_update.do")
	public String boardUpdate(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		BoardDAO dao=new BoardDAO();
		BoardVO vo=dao.boardUpdateDate(Integer.parseInt(no));
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../board/update.jsp");
		
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/board_update_ok.do")
	public String boardUpdate_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		String no=request.getParameter("no");
		String userID=request.getParameter("userID");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");
		String bfile=request.getParameter("bfile");
		BoardVO vo=new BoardVO();
		vo.setNo(Integer.parseInt(no));
		vo.setUser_id(userID);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setPwd(pwd);
		vo.setBfile(bfile);
		
		BoardDAO dao=new BoardDAO();
		boolean bCheck=dao.boardUpdate(vo);
		request.setAttribute("bCheck", bCheck);
		request.setAttribute("no", no);
		return "../board/update_ok.jsp";
	}
	
	@RequestMapping("board/delete.do")
	public String boardDelete(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		BoardDAO dao=new BoardDAO();
		boolean bCheck=dao.boardDelete(Integer.parseInt(no), pwd);
		String temp="";
		if(bCheck==true) {
			temp="yes";
		}
		else {
			temp="no";
		}
		request.setAttribute("result", temp);
		return "../board/delete.jsp";
	}
}
