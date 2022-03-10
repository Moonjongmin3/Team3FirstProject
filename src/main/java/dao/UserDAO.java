package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import vo.*;

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
}
