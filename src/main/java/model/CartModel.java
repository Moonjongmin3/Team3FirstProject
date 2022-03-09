package model;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

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
import dao.PayDAO;
import vo.BookVO;
import vo.PayVO;
import vo.UserVO;

public class CartModel {
	@RequestMapping("cart/Cart.do")
	public String getCart(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setAttribute("main_jsp", "../cart/Cart.jsp");
		
		// 로그인 시 회원 주소 가져오기
		if(request.getSession().getAttribute("userId") != null) {
			PayDAO paydao = new PayDAO();
			UserVO user = paydao.orderer_info(request.getSession().getAttribute("userId").toString());
			request.setAttribute("fullAddress", user.getAddress1() + " " + user.getAddress2());
		}
		
		// 날짜 가져오기
		LocalDate today = LocalDate.now(ZoneId.of("Asia/Seoul")).plusDays(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/dd");
		
		String dow = today.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREA);
		
		String deliveryDate = today.format(formatter) + "," +  dow;
		request.setAttribute("deliveryDate", deliveryDate);
		
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
				(ArrayList<BookVO>)bookDAO.selectListById(bookHistory);
		Collections.reverse(historyBooks);
 
		request.setAttribute("historyBooks", historyBooks);
		return "../main/main.jsp";
	}
}
