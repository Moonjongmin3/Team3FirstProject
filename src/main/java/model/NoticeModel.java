package model;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controller.RequestMapping;
import dao.NoticeDAO;
import vo.NoticeVO;

public class NoticeModel {
	
    @RequestMapping("customer/notice.do")
    public String noticeList(HttpServletRequest request, HttpServletResponse response){
        try {
            request.setCharacterEncoding("UTF-8");
            String type = request.getParameter("type");
            String notice_keyword = request.getParameter("notice_keyword");
            String page = request.getParameter("page");

            if(notice_keyword==null){
            	notice_keyword="";
            }

            if(type==null) {
                type = "title";
            }


            if (page == null) {
                page = "1"; // 첫 페이지 실행(default)

            }
            int curpage = Integer.parseInt(page); // 현재 페이지 만들기
            int block = 5;
            int startpage = ((curpage - 1) / block * block) + 1;
            int endpage = startpage - 1 + block;

            NoticeDAO dao = new NoticeDAO();
            int total = dao.totalCount(type,notice_keyword);
            if (endpage > total) {
                endpage = total;
            }

            List<NoticeVO> list = dao.noticeList(curpage,type,notice_keyword);

            request.setAttribute("path", "공지사항");
            request.setAttribute("type",type);
            request.setAttribute("notice_keyword",notice_keyword);
            request.setAttribute("startpage", startpage);
            request.setAttribute("endpage", endpage);
            request.setAttribute("total", total);
            request.setAttribute("curpage", curpage);
            request.setAttribute("notice_list", list);
            request.setAttribute("cscenter_jsp", "../customer/notice_list.jsp");
            request.setAttribute("main_jsp", "../customer/notice.jsp");
        }catch (Exception e){
            e.printStackTrace();
        }
        return "../main/main.jsp";
    }

    @RequestMapping("customer/notice_detail.do")
    public String noticeDetail(HttpServletRequest request, HttpServletResponse response){

        String no = request.getParameter("no");
        String page = request.getParameter("page");

        NoticeVO vo = new NoticeVO();
        NoticeDAO dao = new NoticeDAO();
        vo= dao.noticeDetailData(Integer.parseInt(no));

        request.setAttribute("path", "공지사항");
        request.setAttribute("notice",vo);
        request.setAttribute("page",page);
        request.setAttribute("cscenter_jsp", "../customer/notice_detail.jsp");
        request.setAttribute("main_jsp","../customer/notice.jsp");
        return "../main/main.jsp";
    }


    @RequestMapping("customer/notice_update.do")
    public String noticeUpdateData(HttpServletRequest request, HttpServletResponse response){
        String no = request.getParameter("no");
        String page = request.getParameter("page");

        NoticeVO vo = new NoticeVO();
        NoticeDAO dao = new NoticeDAO();
        vo = dao.noticeUpdateData(Integer.parseInt(no));
        
        request.setAttribute("path", "공지사항 수정");
        request.setAttribute("notice",vo);
        request.setAttribute("page",page);
        request.setAttribute("cscenter_jsp", "../customer/notice_update.jsp");
        request.setAttribute("main_jsp","../customer/notice.jsp");
        return "../main/main.jsp";
    }

    @RequestMapping("customer/notice_update_ok.do")
    public String noticeUpdate(HttpServletRequest request,HttpServletResponse response){
    	String no = request.getParameter("no");
        String page = request.getParameter("page");
    	try {
           HttpSession session = request.getSession();
           request.setCharacterEncoding("UTF-8");
           String adminID= (String)session.getAttribute("userId");

           int maxSize=1024*1024*200; //200mb
           String path="c:\\download";
   			String enctype="UTF-8";
   			MultipartRequest mr=
    				new MultipartRequest(request, 
    						path,maxSize,enctype,
    						new DefaultFileRenamePolicy());
   			String title=mr.getParameter("title");
    		String userId=adminID;
    		String content=mr.getParameter("content");
    		String filename=mr.getOriginalFileName("upload");
    		
    		
            NoticeVO vo = new NoticeVO();
            vo.setNo(Integer.parseInt(no));
            vo.setTitle(title);
            vo.setContent(content);
            vo.setAdminID(userId);
            
            // 업로드가 안된 상태 
            if(filename==null)
    		{
    			vo.setFilename("");
    			vo.setFilesize(0);
    		}
    		else
    		{
    			File file=new File(path+"\\"+filename);
    			vo.setFilename(file.getName());// 파일명만 저장 
    			vo.setFilesize((int)file.length());
    		}
            NoticeDAO dao = new NoticeDAO();
            dao.noticeUpdate(vo);
            
        }catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:notice_detail.do?no="+no+"&page="+page;
    }
    
    @RequestMapping("customer/notice_delete.do")
    public String noticeDelete(HttpServletRequest request, HttpServletResponse response) {

            String no = request.getParameter("no");
            String page = request.getParameter("page");

            NoticeDAO dao = new NoticeDAO();
            dao.noticeDelete(Integer.parseInt(no));
            
        return "redirect:notice.do?page="+page;
    }
    
    @RequestMapping("customer/notice_insert.do")
    public String noticeInsertForm(HttpServletRequest request, HttpServletResponse response){
        String page = request.getParameter("page");
        
        request.setAttribute("path", "공지사항 작성");
        request.setAttribute("page",page);
        request.setAttribute("cscenter_jsp", "../customer/notice_insert.jsp");
        request.setAttribute("main_jsp","../customer/notice.jsp");
        return "../main/main.jsp";
    }
    
    @RequestMapping("customer/notice_insert_ok.do")
    public String noticeInsert(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            HttpSession session = request.getSession();
    	    String adminID=(String)session.getAttribute("userId");
           
    	    int maxSize=1024*1024*200; //200mb
            String path="c:\\download";
    			String enctype="UTF-8";
    			MultipartRequest mr=
     				new MultipartRequest(request, 
     						path,maxSize,enctype,
     						new DefaultFileRenamePolicy());
    		String title=mr.getParameter("title");
     		String userId=adminID;
     		String content=mr.getParameter("content");
     		String filename=mr.getOriginalFileName("upload");
     		
     		
             NoticeVO vo = new NoticeVO();
             vo.setTitle(title);
             vo.setContent(content);
             vo.setAdminID(userId);
             
             // 업로드가 안된 상태 
             if(filename==null)
     		{
     			vo.setFilename("");
     			vo.setFilesize(0);
     		}
     		else
     		{
     			File file=new File(path+"\\"+filename);
     			vo.setFilename(file.getName());// 파일명만 저장 
     			vo.setFilesize((int)file.length());
     		}
            NoticeDAO dao = new NoticeDAO();
            
            dao.noticeInsertData(vo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:notice.do";
    }
    @RequestMapping("customer/download.do")
    public String noticeDownload(HttpServletRequest request, HttpServletResponse response) {
    	try
    	{
    		request.setCharacterEncoding("UTF-8");
    		//1. File명을 받는다 
    		String fn=request.getParameter("fn");
    		//2. header 생성 => 실제 데이터전에 전송 (클라이언트로)
    		//2-1. 파일 크기 , 파일 이름 => 파일다운로드 창을 보여준다
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
    	return"redirect:../notice/detail.do";
    }
}








