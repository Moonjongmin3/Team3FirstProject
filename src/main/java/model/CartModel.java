package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import controller.RequestMapping;
import dao.BookDAO;
import dao.CartDAO;
import vo.BookVO;

public class CartModel {
	@RequestMapping("cart/Cart.do")
	public String getCart(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
 
		request.setAttribute("main_jsp", "../cart/Cart.jsp");
		return "../main/main.jsp";
	}
}
