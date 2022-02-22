package model;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.RequestMapping;
import dao.BookDAO;
import vo.BookVO;

public class IndexModel extends HttpServlet {

    @RequestMapping("main/main.do")
    public String index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext application = request.getServletContext();

        BookDAO bookDAO = new BookDAO();
        List<BookVO> bestBooks;
        List<BookVO> newBooks;
        List<BookVO> youtubeBooks;
        Map<String, Object> map = new HashMap<String, Object>();

        String sortBy = application.getInitParameter("DEFAULT_SORT");
        System.out.println(sortBy);
        // 베스트 셀러 & 신간 도서 비즈니스 로직 처리
        map.put("sortBy", sortBy);
        map.put("start", 1);
        map.put("end", 12);

        bestBooks = bookDAO.selectList(map);
        map.replace("sortBy", "regdate");
        newBooks = bookDAO.selectList(map);
        youtubeBooks = bookDAO.selectYoutubeList();
//        bookDAO.close();

        request.setAttribute("bestBooks", bestBooks);
        request.setAttribute("newBooks", newBooks);
        request.setAttribute("youtubeBooks", youtubeBooks);
        request.setAttribute("main_jsp", "../main/common.jsp");


        return "../main/main.jsp";
    }
}

