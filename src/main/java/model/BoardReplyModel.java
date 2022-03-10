package model;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.RequestMapping;
import dao.BoardReplyDAO;
import vo.BoardReplyVO;

public class BoardReplyModel {
	@RequestMapping("board/reply_insert.do")
	public String reply_insert(HttpServletRequest request,HttpServletResponse response)
	{
		  try
		  {
			  request.setCharacterEncoding("UTF-8");
		  }catch(Exception ex) {}
		  String page=request.getParameter("page");
		  String no=request.getParameter("no");
		  String board_no=request.getParameter("board_no");
		  String content=request.getParameter("content");// 댓글 
		  // DAO로 전송 => 오라클 추가 
		  HttpSession session=request.getSession();
		  String userId=(String)session.getAttribute("user_id");
		  
		  BoardReplyVO vo=new BoardReplyVO();
		  vo.setNo(Integer.parseInt(no));
		  vo.setUser_id(userId);
		  vo.setContent(content);
		  vo.setBoard_no(Integer.parseInt(board_no));
		  BoardReplyDAO dao=new BoardReplyDAO();
		  dao.replyInsert(vo);
		  request.setAttribute("page",page);
		  request.setAttribute("board_no", board_no);
		  
		  return "redirect:../board/board_detail.do?pag="+page+"no="+board_no;
	  }
	
	@RequestMapping("board/reply_delete.do")
	public String reply_delete(HttpServletRequest request, HttpServletResponse response)
	  {
		   String no=request.getParameter("no"); // 댓글 번호
		   String board_no=request.getParameter("board_no");
		   BoardReplyDAO dao=new BoardReplyDAO();

		   dao.replyDelete(Integer.parseInt(no));
		   
		   return "redirect:../board/board_detail.do?no="+board_no;
	  }
	  
	  @RequestMapping("board/reply_update.do")
	  public String replyUpdate(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  try
		  {
			  request.setCharacterEncoding("UTF-8");
		  }catch(Exception ex) {}
		  String no=request.getParameter("no"); // 댓글 번호
		  String boardNo=request.getParameter("board_no");
		  String content=request.getParameter("content");
		  
		  BoardReplyVO vo=new BoardReplyVO();
		  vo.setNo(Integer.parseInt(no));
		  vo.setContent(content);
		  
		  BoardReplyDAO dao=new BoardReplyDAO();
		  // 수정 메소드 호출 
		  dao.replyUpdate(Integer.parseInt(no), content);
			   
		  return "redirect:../board/board_detail.do?no="+boardNo;
	  }
	
}