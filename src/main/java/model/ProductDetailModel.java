package model;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;
import dao.BookdetailDAO;
import vo.BookVO;




public class ProductDetailModel {
	
	
	@RequestMapping("book/productdetail.do")
	public String productdetail(HttpServletRequest request, HttpServletResponse response) {
		
		BookdetailDAO dao = new BookdetailDAO(); 
		String id =request.getParameter("id");
		BookVO book=dao.BookdetailData(Integer.parseInt(id));
		request.setAttribute("book", book);
		request.setAttribute("main_jsp", "../book/productdetail.jsp");
		
		

		return"../main/main.jsp";
	}

}
