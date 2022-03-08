package model;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.*;
import controller.RequestMapping;
import dao.OneInquiryDAO;
import vo.NoticeVO;
import vo.OneInquiryVO;
public class OneInquiryModel {

	@RequestMapping("customer/one_inquiry.do")
	public String one_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		List<OneInquiryVO> list = new ArrayList<OneInquiryVO>();
		OneInquiryDAO dao= new OneInquiryDAO();
		
		
		int curpage =Integer.parseInt(page);
		int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=startPage-1 +BLOCK;
		
		list=dao.oneInquiryListData(curpage);
		int totalPage= dao.oneTotalPage();
		int totalCount=dao.oneTotalCount();
		
		request.setAttribute("path", "1:1문의 게시판");
		request.setAttribute("curpage", curpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("list", list);
		request.setAttribute("cscenter_jsp", "../customer/one_inquiry.jsp");
        request.setAttribute("main_jsp", "../customer/notice.jsp");
           
        return "../main/main.jsp";
	}
	
	
	@RequestMapping("customer/one_inquiry_detail.do")
	public String one_detail(HttpServletRequest request, HttpServletResponse response) {
		String groupId = request.getParameter("groupId");
		String page = request.getParameter("page");
		OneInquiryDAO dao= new OneInquiryDAO();
		
		OneInquiryVO qvo = new OneInquiryVO();
		qvo=dao.oneDetailQuestionData(Integer.parseInt(groupId));
		qvo.setGroupId(Integer.parseInt(groupId));
		if(qvo.getReplyCheck().equals("Y")) {
			OneInquiryVO avo = new OneInquiryVO();
			avo=dao.oneDetailAnswerData(Integer.parseInt(groupId));
			avo.setGroupId(Integer.parseInt(groupId));
			request.setAttribute("avo", avo);
		}
		
		request.setAttribute("path", "1:1문의 게시판");
		request.setAttribute("page", page);
		request.setAttribute("qvo", qvo);
		request.setAttribute("cscenter_jsp", "../customer/one_inquiry_detail.jsp");
        request.setAttribute("main_jsp", "../customer/notice.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("customer/one_insert.do")
	public String one_Insert(HttpServletRequest request, HttpServletResponse response) {
		
		
		request.setAttribute("path", "1:1문의 작성");
		request.setAttribute("cscenter_jsp", "../customer/one_inquiry_insert.jsp");
        request.setAttribute("main_jsp", "../customer/notice.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("customer/one_insert_ok.do")
	public String one_Insert_ok(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		try {
			int maxSize=1024*1024*200; //200mb
	        String path="/Users/kimheejun/Desktop";
//	        String path="c:\\download";  window는 이거 사용
				String enctype="UTF-8";
				MultipartRequest mr=
	 				new MultipartRequest(request, 
	 						path,maxSize,enctype,
	 						new DefaultFileRenamePolicy());
			String title=mr.getParameter("title");
	 		String content=mr.getParameter("content");
	 		String password = mr.getParameter("password");
	 		String secretCk = mr.getParameter("secretCk");
	 		String groupId=mr.getParameter("groupId");
	 		String filename=mr.getOriginalFileName("file");
	 		
	 		OneInquiryVO vo = new OneInquiryVO();
	 		if(secretCk==null)
	 			secretCk="N";
	 		
	 		if(groupId!=null) { // 어드민이 답변을 작성한 경우
	 			
	 			title="답변";
	 			vo.setTitle(title);
		        vo.setContent(content);
		        vo.setUserId(userId);
		        vo.setSecretCk(secretCk);
		        vo.setGroupId(Integer.parseInt(groupId));
	 			
	 		}else { // 사용자가 질문 작성
		         vo.setTitle(title);
		         vo.setContent(content);
		         vo.setUserId(userId);
		         vo.setPassword(password);
		         vo.setSecretCk(secretCk);
	 		}
	         
	         // 업로드가 안된 상태 
	         if(filename==null){
	 			vo.setFilename("");
	 			vo.setFileSize(0);
	 		}
	 		else
	 		{
	 			File file=new File(path+"/"+filename);
//	 			File file=new File(path+"\\"+filename);  window는 이거 사용
	 			vo.setFilename(file.getName());// 파일명만 저장 
	 			vo.setFileSize((int)file.length());
	 		}
	         OneInquiryDAO dao = new OneInquiryDAO();
	         if(groupId!=null) { 
	        	 dao.oneInsertAnswerData(vo);
	         }else {
	        	 dao.oneInsertQuestionData(vo);
	         }
		}catch (Exception e) {
			e.printStackTrace();
		}
		return"redirect:../customer/one_inquiry.do";
	}
	
	@RequestMapping("customer/one_inquery/download.do")
    public String oneDownload(HttpServletRequest request, HttpServletResponse response) {
			String groupId=request.getParameter("groupId");
    	try
    	{
    		request.setCharacterEncoding("UTF-8");
    		String fn=request.getParameter("fn");
    		File file=new File("/Users/kimheejun/Desktop"+fn);
//    		File file=new File("c:\\download\\"+fn); window
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
    	return"redirect:../customer/one_inquiry_detail.do?groupId="+groupId;
    }
	
		
	@RequestMapping("customer/detail_ok.do")
    public String oneDetailOk(HttpServletRequest request, HttpServletResponse response) {
		String groupId = request.getParameter("groupId");
		String password = request.getParameter("password");
		
		OneInquiryDAO dao = new OneInquiryDAO();
		String result=dao.onePwdCheck(password, Integer.parseInt(groupId));
		
		request.setAttribute("groupId", groupId);
		request.setAttribute("result", result);
		return "../customer/one_pwd.jsp";
	}
	
		
	@RequestMapping("customer/one_delete.do")
    public String oneDelete(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String groupid = request.getParameter("groupid");
		int admin= (int) session.getAttribute("admin");
		
		OneInquiryDAO dao = new OneInquiryDAO();
		if(admin==0) {
			dao.oneUserDelete(Integer.parseInt(groupid));
		}else {
			dao.oneAnswerDelete(Integer.parseInt(groupid));
		}
		
		return "redirect:../customer/one_inquiry.do";
	}
	
	@RequestMapping("customer/one_answer_update.do")
    public String oneUpdateAnswer(HttpServletRequest request, HttpServletResponse response) {
		String groupId = request.getParameter("groupId");
		
		OneInquiryDAO dao = new OneInquiryDAO();
		OneInquiryVO vo = dao.oneDetailAnswerUpdateData(Integer.parseInt(groupId));
		
		request.setAttribute("vo", vo);
		return "../customer/one_inquiry_update.jsp";
	}
}
