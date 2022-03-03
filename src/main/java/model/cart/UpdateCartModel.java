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

@WebServlet("/cart/update")
public class UpdateCartModel extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String bookId = request.getParameter("bookId");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		Map<String,BookVO> cart;
		
		// 로그인 상태
		if (session.getAttribute("userId") != null) {
			String userId = session.getAttribute("userId").toString();
			CartDAO cartDAO = new CartDAO();
			cartDAO.updateCart(quantity, userId, Integer.parseInt(bookId));
			
			cart = (LinkedHashMap<String, BookVO>) cartDAO.getCart(userId);
		// 비로그인 상태
		} else {
			cart = (LinkedHashMap<String, BookVO>) session.getAttribute("cart");
			cart.get(bookId).setQuantity(quantity);
		}
		
		List<BookVO> cartValues = new ArrayList<BookVO>(cart.values());
		if(session.getAttribute("userId") == null) Collections.reverse(cartValues);
		
		Gson gson = new Gson();
		String cartJson = gson.toJson(cartValues);
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		response.getWriter().write(cartJson);
	}
}
