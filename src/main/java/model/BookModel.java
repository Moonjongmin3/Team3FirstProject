package model;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;
import dao.BookListDAO;
import vo.BookCountVO;
import vo.BookVO;
import vo.SearchVO;

public class BookModel {

	@RequestMapping("book/bookList.do")
	public String bookList(HttpServletRequest request, HttpServletResponse response) {
		String category=request.getParameter("searchCategory");
		String keyword=request.getParameter("keyword");
		String page=request.getParameter("page");
		String[] taft=request.getParameterValues("taftck");
		String[] subcate=request.getParameterValues("sub_categoty");
		String sort =request.getParameter("sort");
		String rowSize=request.getParameter("rowsize");
		String except = request.getParameter("except");
		if(except==null) {
			except="Y";
		}
		if(sort==null) {
			sort="sellSort";
		}
		if(taft==null) {
			taft = new String[3];
			taft[0]="title";
			taft[1]="author";
			taft[2]="publisher";
		}
		if(subcate==null) {
			subcate=new String[1];
			subcate[0]="all";
		}
		if(rowSize==null)
			rowSize="10";
		if(page==null)
			page="1";
		int curpage =Integer.parseInt(page);
		int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=startPage-1 +BLOCK;
		
		SearchVO svo = new SearchVO();
		svo.setMainCategory(Integer.parseInt(category));
		svo.setSubcategory(subcate);
		svo.setTaft(taft);
		svo.setKeyword(keyword);
		svo.setPage(curpage);
		svo.setSort(sort);
		svo.setRowSize(Integer.parseInt(rowSize));
		svo.setStockCheck(except);
		
		BookListDAO dao = new BookListDAO();
		List<BookVO> list = new ArrayList<>();
		list=dao.bookSearchList(svo);
		int totalPage=dao.searchTotalPage(svo);
		int[] mainCountArr=dao.searchBookCount(svo);
		List<BookCountVO> subCountList = dao.bookSearchCount(svo);
		int totalCount = dao.searchResultCount(svo);
		
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		request.setAttribute("svo", svo);
		request.setAttribute("subCountList", subCountList);
		request.setAttribute("mainCountArr", mainCountArr);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("category", category);
		request.setAttribute("keyword", keyword);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("main_jsp", "../book/bookList.jsp");
		return "../main/main.jsp";
	}
}
