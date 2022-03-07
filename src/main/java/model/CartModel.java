package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
		
		Cookie cookie = (Cookie)BookCookieManager.findCookie(request, "history");
		String[] bookHistory = cookie.getValue().split("x");
		
		BookDAO bookDAO = new BookDAO();
		List<BookVO> historyBooks = (ArrayList<BookVO>)bookDAO.selectListById(bookHistory);
		for(BookVO book : historyBooks) {
			System.out.println(book.getName());
		}
 
		request.setAttribute("historyBooks", historyBooks);
		request.setAttribute("main_jsp", "../cart/Cart.jsp");
		return "../main/main.jsp";
	}
}
