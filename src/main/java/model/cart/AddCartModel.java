package model.cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookDAO;
import dao.CartDAO;
import vo.BookVO;

@WebServlet("/cart/addCart")
public class AddCartModel extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 책 id 가져오기
		String bookId = request.getParameter("bookId");
		
		//로그인 상태
		if (session.getAttribute("userId") != null) {
			String userId = session.getAttribute("userId").toString();
			CartDAO cartDAO = new CartDAO();
			int checkedQuantity = cartDAO.checkCart(userId, bookId);
			// 이미 해당 책 존재하는 경우
			if(checkedQuantity > 0) {
				cartDAO.updateCart((checkedQuantity+1), userId, Integer.parseInt(bookId));
				return;
			}
			BookDAO bookDAO = new BookDAO();
			BookVO book = bookDAO.findBook(bookId);
			cartDAO.insertCart(book, userId);
		} else {
			// 비회원 상태
			if (session.getAttribute("cart") == null) {
				Map<String,BookVO> cart = new LinkedHashMap<>();
				session.setAttribute("cart", cart);
			}
			Map<String,BookVO> cart = (LinkedHashMap<String, BookVO>) session.getAttribute("cart");
			
			// 이미 해당 책 존재하는 경우
			if(cart.containsKey(bookId) == true) {
				cart.get(bookId).setQuantity(cart.get(bookId).getQuantity() + 1);
				return;
			}
			BookDAO bookDAO = new BookDAO();
			BookVO book = bookDAO.findBook(bookId);
			cart.put(bookId, book);
		}
	}
}
