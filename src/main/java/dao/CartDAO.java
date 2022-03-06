package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import Common.DBConnPool;
import vo.BookVO;

public class CartDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	private ConnectionManager cm;
	
    private final static String INSERT_Q = "INSERT INTO CART_3 VALUES (CART_3_ID_SEQ.NEXTVAL,?,?,?)";
    private final static String SELECT_Q = "SELECT b.*, mc.NAME main_category, sc.NAME sub_category, c.quantity quantity FROM cart_3 c "
								    		+ "INNER JOIN BOOKS_3 b ON c.BOOK_ID = b.ID "
								    		+ "INNER JOIN SUB_CATEGORY_3 sc ON b.CATEGORY_ID = sc.ID "
								    		+ "INNER JOIN MAIN_CATEGORY_3 mc ON sc.MAIN_ID = mc.ID WHERE user_id = ? ORDER BY c.cart_id DESC";
    private final static String DELETE_Q = "DELETE FROM CART_3 c WHERE USER_ID = ? AND BOOK_ID = ?";
    private final static String UPDATE_Q = "UPDATE CART_3 SET quantity = ? WHERE user_id = ? AND book_id = ?";
    
    public CartDAO() {
    	cm = new ConnectionManager();
    }

    public LinkedHashMap<String, BookVO> getCart(String userId) {
    	Map<String, BookVO> cart = new LinkedHashMap<String, BookVO>();
    	try {
    		conn = cm.getConnection();
    		ps = conn.prepareStatement(SELECT_Q);
    		ps.setString(1,userId);
    		rs = ps.executeQuery();
    		
    		while (rs.next()) {
                BookVO book = new BookVO();
                int bookId = rs.getInt("id");
                book.setId(bookId);
                book.setPoster(rs.getString("poster"));
                book.setName(rs.getString("title"));
                book.setPrice(Integer.parseInt(rs.getString("price")));
                book.setQuantity(Integer.parseInt(rs.getString("quantity")));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setSaleRate(rs.getInt("salerate"));
                book.setScore(rs.getInt("score"));
                book.setIsbn(rs.getString("isbn"));
                book.setBsize(rs.getString("bsize"));
                book.setState(rs.getString("state"));
                book.setTag(rs.getString("tag"));
                book.setMainCategory(rs.getString("main_category"));
                book.setSubCategory(rs.getString("sub_category"));
                
                cart.put(Integer.toString(bookId), book);
            }
    		rs.close();
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cm.disConnection(conn, ps);
		}
		return (LinkedHashMap<String, BookVO>) cart;
    }
    
    public void insertCart(BookVO book, String userId) {
        try {
        	conn = cm.getConnection();
            ps = conn.prepareStatement(INSERT_Q);
            ps.setString(1,userId);
            ps.setInt(2,book.getId());
            ps.setInt(3,book.getQuantity());

            ps.executeUpdate();
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	cm.disConnection(conn, ps);
        }
    }
    
    public void deleteCart(int bookId, String userId) {
        try {
        	conn = cm.getConnection();
            ps = conn.prepareStatement(DELETE_Q);
            ps.setString(1,userId);
            ps.setInt(2,bookId);

            ps.executeUpdate();
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	cm.disConnection(conn, ps);
        }
    }
    
    public void updateCart(int quantity, String userId, int bookId) {
        try {
        	conn = cm.getConnection();
            ps = conn.prepareStatement(UPDATE_Q);
            ps.setInt(1,quantity);
            ps.setString(2,userId);
            ps.setInt(3,bookId);

            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	cm.disConnection(conn, ps);
        }
    }

}
