package dao;

import Common.*;
import vo.BookVO;

import java.sql.*;
import java.util.*;

public class JjimDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	private ConnectionManager cm;
	
	public List<BookVO> JjimList(String user_id){
		List<BookVO> list=new ArrayList<BookVO>();
		try {
			conn=cm.getConnection();
			String sql="SELECT no,user_id,book_id "
						+"FROM wish_list "
						+"WHERE user_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, user_id);
			rs=ps.executeQuery();
			
			while(rs.next()) {
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
			}
			rs.close();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return list;
	}
	

	//SQL문자에 no값은 따로 지정안해도되는지
	public void insertJjim(BookVO book, String user_id) {
		try {
			conn=cm.getConnection();
			String sql="INSERT INTO wish_list VALUES( "
					 +"no,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, user_id);
			ps.setInt(2, book.getId());
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	
	public void deleteJjim(int book_id, String user_id) {
        try {
        	conn = cm.getConnection();
        	String sql="DELETE FROM wish_list "
        			+"WHERE user_id=? AND book_id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,user_id);
            ps.setInt(2,book_id);

            ps.executeUpdate();
            

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	cm.disConnection(conn, ps);
        }
    }
	
	//찜이 되어있는지 체크해주는 메소드
	public int checkJjim(String user_id,String book_id) {
		int count=0;
		try {
			conn=cm.getConnection();
			String sql="SELECT COUNT(*) FROM wish_list "
					+"WHERE user_id=? AND book_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, user_id);
			ps.setString(2, book_id);
			rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return count;
	}
	
    
}
