package model;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;
import dao.BookListDAO;
import vo.BookVO;

public class BookModel {

	@RequestMapping("book/bookList.do")
	public String bookList(HttpServletRequest request, HttpServletResponse response) {
		String category=request.getParameter("searchCategory");
		String keyword=request.getParameter("keyword");
		String page=request.getParameter("page");
//		int cate=4;
//		if(category.equals("국내도서")) 
//			cate=1;
//		if(category.equals("외국도서")) 
//			cate=2;
//		if(category.equals("e-book"))
//			cate=3;
		if(page==null)
			page="1";
		
		int curpage =Integer.parseInt(page);
		int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=startPage-1 +BLOCK;
		
		BookListDAO dao = new BookListDAO();
		List<BookVO> list = new ArrayList<>();
		list=dao.bookSearchList(Integer.parseInt(category), keyword, curpage);
		int totalPage=dao.searchTotalCount(Integer.parseInt(category), keyword);
		int totalCount=dao.searchBookCount(Integer.parseInt(category), keyword);
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("category", category);
		request.setAttribute("keyword", keyword);
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("main_jsp", "../book/bookList.jsp");
		return "../main/main.jsp";
	}
}
