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
	@RequestMapping("reply/reply_insert.do")
	public String reply_insert(HttpServletRequest request,HttpServletResponse response)
	{
		  try
		  {
			  request.setCharacterEncoding("UTF-8");
		  }catch(Exception ex) {}
		  String boardNo=request.getParameter("board_no");
		  String content=request.getParameter("content");// 댓글 
		  // DAO로 전송 => 오라클 추가 
		  HttpSession session=request.getSession();
		  String userId=(String)session.getAttribute("user_id");
		  
		  BoardReplyVO vo=new BoardReplyVO();
		  vo.setUser_id(userId);
		  vo.setContent(content);
		  vo.setBoard_no(Integer.parseInt(boardNo));
		  BoardReplyDAO dao=new BoardReplyDAO();
		  dao.replyInsert(vo);
		  
		  return "redirect:../board/board_detail.do?no="+boardNo;
	  }
	
	@RequestMapping("reply/reply_delete.do")
	public String reply_delete(HttpServletRequest request, HttpServletResponse response)
	  {
		   String no=request.getParameter("no"); // 댓글 번호
		   String boardNo=request.getParameter("board_no");
		   String content=request.getParameter("content");
		   BoardReplyDAO dao=new BoardReplyDAO();

		   dao.replyDelete(Integer.parseInt(no));
		   return "redirect:../board/board_detail.do?no="+boardNo;
	  }
	  
	  @RequestMapping("reply/reply_update.do")
	  public String replyUpdate(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  try
		  {
			  request.setCharacterEncoding("UTF-8");
		  }catch(Exception ex) {}
		  String no=request.getParameter("no"); // 댓글 번호
		  String boardNo=request.getParameter("board_no"); // 맛집번호 
		  String content=request.getParameter("content");
		  BoardReplyDAO dao=new BoardReplyDAO();
		  // 수정 메소드 호출 
		  dao.replyUpdate(Integer.parseInt(no), content);
			   
		  return "redirect:../board/board_detail.do?no="+boardNo;
	  }
	}
}

