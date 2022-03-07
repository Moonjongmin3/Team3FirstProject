package model;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Common.BookCookieManager;
import controller.RequestMapping;
import dao.BookdetailDAO;
import vo.BookVO;




public class ProductDetailModel {
	
	 
	
	@RequestMapping("book/productdetail.do")
	 public String productdetail(HttpServletRequest request, HttpServletResponse response) {
		
		BookdetailDAO dao = new BookdetailDAO(); 
		String id =request.getParameter("no");
		BookVO book=dao.BookdetailData(Integer.parseInt(id));
		request.setAttribute("book", book);
		request.setAttribute("main_jsp", "../book/productdetail.jsp");
		
		// 쿠키에 최근 본 상품 저장
		Cookie cookie;
		if(BookCookieManager.findCookie(request, "history") == null) {
			// 쿠키가 없을 때
			cookie = new Cookie("history", id);
		} else {
			// 쿠키가 존재할 때
			cookie = (Cookie)BookCookieManager.findCookie(request, "history");
			String history = cookie.getValue() + "x" + id;
			cookie.setValue(history);			
		}
		cookie.setMaxAge(60);
		cookie.setPath("/FirstProject");
		response.addCookie(cookie);

		return"../main/main.jsp";
	}

}
