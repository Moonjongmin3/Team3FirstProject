package dao;


import vo.OneInquiryVO;
import java.util.*;
import java.sql.*;
public class OneInquiryDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ConnectionManager cm = new ConnectionManager();
	
	public List<OneInquiryVO> oneInquiryListData(int page){
		List<OneInquiryVO> list = new ArrayList<OneInquiryVO>();
		try {
			conn=cm.getConnection();
			String sql="SELECT no,user_id,title,create_at,secret_check,group_id,username,reply_check, num "
					+ "FROM (SELECT no,user_id,title,create_at,secret_check,group_id,username,reply_check,rownum as num "
					+ "FROM (SELECT no,user_id,title,create_at,secret_check,group_id,u.NAME as username,reply_check "
					+ "FROM user_question_3 q,USER_3 u "
					+ "WHERE q.USER_ID=u.id AND group_step=0 "
					+ "ORDER BY group_id DESC)) "
					+ "WHERE num BETWEEN ? AND ? ";
			ps=conn.prepareStatement(sql);
			
			int rowSize=10;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			
			ps.setInt(1, start);
			ps.setInt(2, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				OneInquiryVO vo = new OneInquiryVO();
				int no =rs.getInt(1);
				vo.setNo(no);
				vo.setUserId(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setCreatedAt(rs.getDate(4));
				vo.setSecretCk(rs.getString(5));
				vo.setGroupId(rs.getInt(6));
				vo.setUsername(rs.getString(7));
				vo.setReplyCheck(rs.getString(8));
				
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		return list;
	}
	
	public int oneTotalPage() {
		int total=0;
		try {
			conn=cm.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM user_question_3";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return total;
	}
	
	public int oneTotalCount() {
		int total=0;
		try {
			conn=cm.getConnection();
			String sql="SELECT COUNT(*) FROM user_question_3 "
					+ "WHERE group_step=0";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return total;
	}
	
	public OneInquiryVO oneDetailQuestionData(int groupId) {
		OneInquiryVO vo = new OneInquiryVO();
		try {
			conn=cm.getConnection();
			String sql="UPDATE user_question_3 SET hit=hit+1 "
					+ "WHERE group_step=0 AND group_id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.executeUpdate();
					
			sql="SELECT no, user_id, title, contents, filename, filesize, create_at, hit,reply_check, u.NAME "
					+ "FROM user_question_3 q,USER_3 u "
					+ "WHERE q.USER_ID=u.id AND group_step=0 AND group_id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setUserId(rs.getString(2));
			vo.setTitle(rs.getString(3));
			vo.setContent(rs.getString(4));
			if(rs.getString(5)!=null) {
				vo.setFilename(rs.getString(5));
				vo.setFileSize(rs.getInt(6));
			}
			vo.setCreatedAt(rs.getDate(7));
			vo.setHit(rs.getInt(8));
			vo.setReplyCheck(rs.getString(9));
			vo.setUsername(rs.getString(10));
			
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
	public OneInquiryVO oneDetailAnswerData(int groupId) {
		OneInquiryVO vo = new OneInquiryVO();
		try {
			conn=cm.getConnection();
			String sql="SELECT no, user_id, title, contents, filename, filesize, create_at, hit,u.NAME "
					+ "FROM user_question_3 q,USER_3 u "
					+ "WHERE q.USER_ID=u.id AND group_step=1 AND group_id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			System.out.println("groupId "+groupId);
			ResultSet rs=ps.executeQuery();
			rs.next();
			System.out.println(rs.getInt(1));
			vo.setNo(rs.getInt(1));
			vo.setUserId(rs.getString(2));
			vo.setTitle(rs.getString(3));
			vo.setContent(rs.getString(4));
			if(rs.getString(5)!=null) {
				vo.setFilename(rs.getString(5));
				vo.setFileSize(rs.getInt(6));
			}
			vo.setCreatedAt(rs.getDate(7));
			vo.setHit(rs.getInt(8));
			
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
	
	public void oneInsertQuestionData(OneInquiryVO vo) {
		try {
			conn=cm.getConnection();
			String sql="insert into USER_QUESTION_3 (NO, USER_ID, TITLE, CONTENTS,filename,filesize, CREATE_AT, HIT, SECRET_CHECK, PASSWORD, GROUP_ID, GROUP_STEP) "
					+ "values "
					+ "((SELECT NVL(MAX(no)+1,1)FROM USER_QUESTION_3),?,?,?,?,?,sysdate,0,?,?,(SELECT NVL(MAX(group_id)+1,1) FROM USER_QUESTION_3),0)";
			ps=conn.prepareStatement(sql);
			ps.setString(1,vo.getUserId());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getFilename());
			ps.setInt(5, vo.getFilesize());
			ps.setString(6, vo.getSecretCk());
			if(vo.getSecretCk().equals("Y")) {
				ps.setString(7, vo.getPassword());
			}else {
				ps.setString(7, null);
			}
			ps.executeUpdate();
			
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	
	public void oneInsertAnswerData(OneInquiryVO vo) {
		try {
			conn=cm.getConnection();
			String sql="insert into USER_QUESTION_3 (NO, USER_ID, TITLE, CONTENTS,filename,filesize, CREATE_AT, HIT, SECRET_CHECK, PASSWORD, GROUP_ID, GROUP_STEP) "
					+ "values "
					+ "((SELECT NVL(MAX(no)+1,1)FROM USER_QUESTION_3),?,?,?,?,?,sysdate,0,'N',null,?,1)";
			ps=conn.prepareStatement(sql);
			ps.setString(1,vo.getUserId());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getFilename());
			ps.setInt(5, vo.getFilesize());
			ps.setInt(6, vo.getGroupId());
			
			ps.executeUpdate();
			
			sql="update USER_QUESTION_3 "
					+ "set REPLY_CHECK='Y' "
					+ "where GROUP_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getGroupId());
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	public String onePwdCheck(String password, int groupId) {
		String result="";
		try {
			conn=cm.getConnection();
			String sql="SELECT COUNT(*) FROM USER_QUESTION_3 "
					+ "WHERE group_id=? AND password=? AND group_step=0";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int i = rs.getInt(1);
			rs.close();
			if(i==0) {
				result="N";
			}else {
				result="Y";
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return result;
	}
	public void oneUserDelete(int groupId) {
		try {
			conn=cm.getConnection();
			String sql="DELETE user_question_3 "
					+ "WHERE group_id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		
	}
	public void oneAnswerDelete(int groupId) {
		try {
			conn=cm.getConnection();
			conn.setAutoCommit(false);
			String sql="DELETE user_question_3 "
					+ "WHERE group_id=? AND group_step=1";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.executeUpdate();
			sql="UPDATE user_question_3 "
					+ "SET REPLY_CHECK='N' "
					+ "WHERE group_id=? AND group_step=0";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ps.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		
	}
	
	public OneInquiryVO oneDetailAnswerUpdateData(int groupId) {
		OneInquiryVO vo = new OneInquiryVO();
		try {
			conn=cm.getConnection();
			String sql="SELECT no, user_id, title, contents, filename, CREATE_AT,group_id "
					+ "FROM user_question_3 "
					+ "WHERE group_step=1 AND group_id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, groupId);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setUserId(rs.getString(2));
			vo.setTitle(rs.getString(3));
			vo.setContent(rs.getString(4));
			if(rs.getString(5)!=null) {
				vo.setFilename(rs.getString(5));
			}
			vo.setCreatedAt(rs.getDate(6));
			vo.setGroupId(rs.getInt(7));
			
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
}
