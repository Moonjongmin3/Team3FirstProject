package model;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import dao.BoardDAO;
import vo.BoardVO;
import model.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controller.RequestMapping;


public class BoardModel {
	@RequestMapping("board/list.do")
	public String boardList(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			String type=request.getParameter("type");
			String board_keyword=request.getParameter("board_keyword");
			String page=request.getParameter("page");
			if(board_keyword==null) {
				board_keyword="";
			}
			
			if(type==null) {
				type="title";
			}
			
			if(page==null) {
				page="1";
			}
			int curpage=Integer.parseInt(page);
			int block=5;
			int startpage=((curpage-1)/block*block)+1;
			int endpage=startpage-1+block;
			
			BoardDAO dao=new BoardDAO();
			int totalpage=dao.boardTotalPage(type,board_keyword);
			if(endpage>totalpage) {
				endpage=totalpage;
			}
			
			List<BoardVO> list=dao.boardList(curpage,type,board_keyword);
			request.setAttribute("type", type);
			request.setAttribute("board_keyword", board_keyword);
			request.setAttribute("curpage", curpage);
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
		
		BoardVO vo=new BoardVO();
		BoardDAO dao=new BoardDAO();
		vo=dao.boardDetailData(Integer.parseInt(no));
		
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

		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
        try {
            int maxSize=1024*1024*200;
            String path="c:\\download";
            String enctype="UTF-8";
            MultipartRequest mr=new MultipartRequest(request,path,maxSize,enctype,new DefaultFileRenamePolicy());
 
            String title = mr.getParameter("title");
            String content = mr.getParameter("content");
            String bfile=mr.getOriginalFileName("file");
    	    String pwd = mr.getParameter("pwd");
           
            BoardVO vo = new BoardVO();
            vo.setTitle(title);
            vo.setContent(content);
            vo.setUser_id(userId);
            vo.setPwd(pwd);
            if(bfile==null) {
            	vo.setBfile("");
            }
            else {
            	File file=new File(path+"\\"+bfile);
            	vo.setBfile(file.getName());
            }
            BoardDAO dao = new BoardDAO();
            dao.boardInsert(vo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:../board/list.do";
    }
	
	@RequestMapping("board/download.do")
    public String boardDownload(HttpServletRequest request, HttpServletResponse response) {
    	try
    	{
    		request.setCharacterEncoding("UTF-8");
    		String fn=request.getParameter("fn");
    		File file=new File("c:\\download\\"+fn);
    		response.setContentLength((int)file.length());
    		response.setHeader("Content-Disposition", "attachment;filename="
    				          +URLEncoder.encode(fn, "UTF-8"));
    		BufferedInputStream bis=
    				new BufferedInputStream(new FileInputStream(file));
    		BufferedOutputStream bos=
    				new BufferedOutputStream(response.getOutputStream());
    		
    		int i=0;
    		byte[] buffer=new byte[1024];
    		while((i=bis.read(buffer, 0, 1024))!=-1)
    		{
    			bos.write(buffer, 0, i);
    		}
    		bis.close();
    		bos.close();
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return"redirect:../board/detail.do";
    }
	
	@RequestMapping("board/board_update.do")
	public String boardUpdate(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		String page=request.getParameter("page");
		BoardVO vo=new BoardVO();
		BoardDAO dao=new BoardDAO();
		vo=dao.boardUpdateDate(Integer.parseInt(no));
		
		request.setAttribute("no", no);
		request.setAttribute("page", page);
		request.setAttribute("board", vo);
		request.setAttribute("main_jsp", "../board/list.jsp");
		
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/board_update_ok.do")
	public String boardUpdate_ok(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		String page=request.getParameter("page");
		try {
			request.setCharacterEncoding("UTF-8");
			HttpSession session=request.getSession();
			String user_id=request.getParameter("user_id");
			
			int maxSize=1024*1024*200; 
            String path="c:\\download";
   			String enctype="UTF-8";
			MultipartRequest mr=new MultipartRequest(request,path,maxSize,enctype,new DefaultFileRenamePolicy());
			String title = mr.getParameter("title");
            String content = mr.getParameter("content");
            String bfile=mr.getOriginalFileName("file");
    	    String pwd = mr.getParameter("pwd");
    	    
    	    BoardVO vo=new BoardVO();
    	    vo.setNo(Integer.parseInt(no));
    	    vo.setUser_id(user_id);
    	    vo.setTitle(title);
    	    vo.setContent(content);
    	    vo.setPwd(pwd);
    	    vo.setBfile(bfile);
    	    
    	    if(bfile==null) {
    	    	vo.setBfile("");
    	    }
    	    else {
    	    	File file=new File(path+"\\"+bfile);
    	    	vo.setBfile(file.getName());
    	    }
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}

		// update가 정상적으로 이루어 졌으면 detail로 다시 이동하게 해야됨
		//return "../board/board_detail.do?no="+no (페이지도 넘겨줘야하면 넘겨줘야 함)
		return "../board/board_detail.do?no="+no+"&page="+page;
	}
	
	@RequestMapping("board/delete.do")
	public String boardDelete(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		String page=request.getParameter("page");
		
		BoardDAO dao=new BoardDAO();
		dao.boardDelete(Integer.parseInt(no));

		// board_delete 페이지를 띄울건지?
		// 그럴꺼면 request.setAttribute("main_jsp","../board/board_delete.jsp")
		//return "../main/main.jsp"
		return "redirect:../board/list.do?page="+page;
	}
}
