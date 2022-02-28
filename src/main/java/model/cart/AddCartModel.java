package model.cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
		
		// 책 객체 생성
		BookDAO bookDAO = new BookDAO();
		String bookId = request.getParameter("bookId");
		System.out.println(bookId);
		BookVO book = bookDAO.findBook(bookId);
		
		//로그인 상태
		if (session.getAttribute("userId") != null) {
			// 카트 ID 가져오기
			CartDAO cartDAO = new CartDAO();
			String userId = session.getAttribute("userId").toString();
			int cartId = cartDAO.getCartId(userId);
			// 카트에 책 넣기
			cartDAO.insert(book, cartId);
			// 연결 해제
			cartDAO.close();
		} else {
			// 비회원 상태
			if (session.getAttribute("cart") == null) {
				List<BookVO> cart = new ArrayList<>();
				session.setAttribute("cart", cart);
			}
			List<BookVO> cart = (ArrayList<BookVO>) session.getAttribute("cart");
			cart.add(book);
		}
	}
}
