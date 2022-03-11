package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.OneInquiryVO;
import vo.OrderHistoryVO;
import vo.UserVO;

public class UserDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ConnectionManager cm = new ConnectionManager();
	
	public UserVO getUserData (String userId) {
		UserVO vo = new UserVO();
		try {
			conn=cm.getConnection();
			String sql="SELECT id, name, birth,gender,tel,email,address1,address2,post,registered_at,point,content "
					+ "FROM user_3 "
					+ "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
			rs.next();
			vo.setId(rs.getString(1));
			vo.setName(rs.getString(2));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String birth = sdf.format(rs.getDate(3));
			vo.setBirth(birth);
			vo.setGender(rs.getString(4));
			vo.setTel(rs.getInt(5));
			vo.setEmail(rs.getString(6));
			vo.setAddress1(rs.getString(7));
			String address2=rs.getString(8);
			if(address2==null)
				address2="";
			vo.setAddress2(address2);
			vo.setPost(rs.getInt(9));
			String registed=sdf.format(rs.getDate(10));
			vo.setRegistered_at(registed);
			vo.setPoint(rs.getInt(11));
			vo.setContent(rs.getString(12));
			rs.close();
			
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return vo;
	}
	
	public void UserUpdate (UserVO vo) {
		try {
			conn=cm.getConnection();
			String sql="UPDATE user_3 "
					+ "SET name=?, birth=TO_DATE(?,'YYYY-MM-DD'), gender=?, tel=?, email=?, address1=?, address2=?, post=?,content=? "
					+ "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getBirth());
			ps.setString(3, vo.getGender());
			ps.setInt(4, vo.getTel());
			ps.setString(5, vo.getEmail());
			ps.setString(6, vo.getAddress1());
			ps.setString(7, vo.getAddress2());
			ps.setInt(8, vo.getPost());
			ps.setString(9, vo.getContent());
			ps.setString(10, vo.getId());
			
			ps.executeUpdate();
			
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	
	public String UserDelete (String pwd, String userId) {
		String result="";
		try {
			conn=cm.getConnection();
			String sql="SELECT password FROM user_3 WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String db_pwd = rs.getString(1);
			rs.close();
			if(db_pwd.equals(pwd)) {
				sql="DELETE FROM user_3 WHERE id=?";
				result="Y";
				ps=conn.prepareStatement(sql);
				ps.setString(1, userId);
				ps.executeUpdate();
			}else {
				result="NO";
			}
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return result;
	}
	
	public Map<String,OneInquiryVO> getStayAnswerOneData(){
		Map<String,OneInquiryVO> list = new HashMap<>();
		try {
			conn=cm.getConnection();
			String sql="SELECT no,user_id,title,create_at,reply_check,name,group_id "
					+ "FROM user_question_3, user_3 "
					+ "WHERE user_id=id AND reply_check='N' "
					+ "ORDER BY create_at";
			ps=conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				OneInquiryVO vo = new OneInquiryVO();
				vo.setNo(rs.getInt(1));
				vo.setUserId(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setCreatedAt(rs.getDate(4));
				vo.setReplyCheck(rs.getString(5));
				vo.setUsername(rs.getString(6));
				vo.setGroupId(rs.getInt(7));
		
				list.put(Integer.toString(rs.getInt(1)), vo);
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
	
	public Map<String,OrderHistoryVO> getStayOrderData(){
		Map<String,OrderHistoryVO> list = new HashMap<>();
		try {
			conn=cm.getConnection();
			String sql="SELECT o.order_id,user_id,order_date,total_price,oi.QUANTITY,b.TITLE,b.POSTER,b.PRICE,oi.book_id "
					+ "FROM orders_3 o,ORDER_ITEM_3 oi,BOOKS_3 b "
					+ "WHERE o.ORDER_ID=oi.ORDER_ID AND o.state='주문완료' AND oi.BOOK_ID=b.ID order by ORDER_DATE, ORDER_ID desc";
			ps=conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			int i=1;
			while(rs.next()) {
				OrderHistoryVO vo = new OrderHistoryVO();
				vo.setOrder_id(rs.getInt(1));
				vo.setUser_id(rs.getString(2));
				vo.setOrder_date(rs.getDate(3));
				vo.setTotal_price(rs.getInt(4));
				vo.setQuantity(rs.getInt(5));
				vo.setBookName(rs.getString(6));
				vo.setPoster(rs.getString(7));
				vo.setBookPirce(rs.getString(8));
				vo.setBook_id(rs.getInt(9));
				
				list.put(Integer.toString(i++), vo);
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
	
	public void adminOrderOk(int orderId) {
		try {
			conn=cm.getConnection();
			String sql="Update orders_3 SET state='승인완료', pay_state=1 WHERE order_id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, orderId);
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
}
