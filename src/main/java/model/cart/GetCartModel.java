package model.cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.CartDAO;
import vo.BookVO;

@WebServlet("/cart/get")
public class GetCartModel extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Map<String,BookVO> cart;
		//로그인 상태
		if (session.getAttribute("userId") != null) {
			System.out.println("회원카트!");
			CartDAO cartDAO = new CartDAO();
			String userId = session.getAttribute("userId").toString();
			
			if (session.getAttribute("cart") != null && session.getAttribute("isLogin") == null) {
				Map<String,BookVO> guestCart = (LinkedHashMap<String, BookVO>) session.getAttribute("cart");
				for(BookVO book : guestCart.values()) cartDAO.insertCart(book, userId);
				System.out.println("비회원 카트에 있는 상품 회원카트로 옮기기 완료!");
				session.removeAttribute("cart");
				System.out.println("비회원카트 삭제!");
			}			
			
			cart = (LinkedHashMap<String, BookVO>) cartDAO.getCart(userId);
			System.out.println("DAO에서 회원카트 가져오기 완료!");
			session.setAttribute("isLogin", "T");	

		} else {
			// 비회원 상태
			System.out.println("비회원 카트!");
			cart = (LinkedHashMap<String, BookVO>) session.getAttribute("cart");
		}
		List<BookVO> cartValues = new ArrayList<BookVO>(cart.values());
		if(session.getAttribute("userId") == null) Collections.reverse(cartValues);
		
		Gson gson = new Gson();
		String cartJson = gson.toJson(cartValues);
		System.out.println(cartJson);
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		response.getWriter().write(cartJson);
	}
}
