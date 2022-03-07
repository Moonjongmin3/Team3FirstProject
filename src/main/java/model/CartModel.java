package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import Common.BookCookieManager;
import controller.RequestMapping;
import dao.BookDAO;
import dao.CartDAO;
import vo.BookVO;

public class CartModel {
	@RequestMapping("cart/Cart.do")
	public String getCart(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setAttribute("main_jsp", "../cart/Cart.jsp");
		
		// 최근 본 상품 없을 경우
		if(BookCookieManager.findCookie(request, "history") == null) {
			return "../main/main.jsp";
		}
		
		// 최근 본 상품 존재하는 경우
		Cookie cookie = (Cookie)BookCookieManager.findCookie(request, "history");
		String cookieValue = cookie.getValue().replaceAll("x", ",");
		String[] bookHistory = cookieValue.split(",");
		
		BookDAO bookDAO = new BookDAO();
		List<BookVO> historyBooks = 
				(ArrayList<BookVO>)bookDAO.selectListById(bookHistory, cookieValue);
		Collections.reverse(historyBooks);
 
		request.setAttribute("historyBooks", historyBooks);
		return "../main/main.jsp";
	}
}
