package dao;


import vo.OneInquiryVO;
import java.util.*;
import java.sql.*;
public class OneInquiryDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ConnectionManager cm = new ConnectionManager();
	
	public List<OneInquiryVO> oneInquiryListData(int page, String keyword,int cate,String userId){
		List<OneInquiryVO> list = new ArrayList<OneInquiryVO>();
		StringBuffer sbSql= new StringBuffer();
		String searchCate="";
		if(cate==1) 
			searchCate= "AND title LIKE '%'||'"+keyword+"'||'%' ";
		if(cate==2) 
			searchCate="AND content LIKE '%'||'"+keyword+"'||'%' ";
		if(cate==3) 
			searchCate="AND title LIKE '%'||'"+keyword+"'||'%' OR content LIKE '%'||'"+keyword+"'||'%' ";
		
		String user="";
		if(userId!=null) {
			user="AND user_id='"+userId+"' ";
			System.out.println("user");
		}
		
		try {
			
			sbSql = new StringBuffer("SELECT no,user_id,title,create_at,secret_check,group_id,username,reply_check, num "
					+ "FROM (SELECT no,user_id,title,create_at,secret_check,group_id,username,reply_check,rownum as num "
					+ "FROM (SELECT no,user_id,title,create_at,secret_check,group_id,u.NAME as username,reply_check "
					+ "FROM user_question_3 q,USER_3 u "
					+ "WHERE q.USER_ID=u.id AND group_step=0 "+searchCate+user);
			
			sbSql.append("ORDER BY group_id DESC)) ");
			sbSql.append("WHERE num BETWEEN ? AND ? ");
			conn=cm.getConnection();
			ps=conn.prepareStatement(sbSql.toString());
			
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
				if(userId!=null) {
					vo.setMylist("Y");
				}
				
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
	
	public int oneTotalPage(String keyword,int cate,String userId ) {
		int total=0;
		try {
		String searchCate="";
			if(cate==1) 
				searchCate= " AND title LIKE '%'||'"+keyword+"'||'%'";
			if(cate==2) 
				searchCate=" AND content LIKE '%'||'"+keyword+"'||'%'";
			if(cate==3) 
				searchCate=" AND title LIKE '%'||'"+keyword+"'||'%' OR content LIKE '%'||'"+keyword+"'||'%'";
		
			String user="";
			if(userId!=null) {
				user=" AND user_id='"+userId+"'";
			}
			
			conn=cm.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM user_question_3 WHERE group_step=0";
			if(cate==4) {
				sql+=searchCate;
			}
			sql+=user;
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
	
	public int oneTotalCount(String keyword,int cate,String userId) {
		int total=0;
		try {
			String searchCate="";
			if(cate==1) 
				searchCate= " AND title LIKE '%'||'"+keyword+"'||'%'";
			if(cate==2) 
				searchCate=" AND content LIKE '%'||'"+keyword+"'||'%'";
			if(cate==3) 
				searchCate=" AND title LIKE '%'||'"+keyword+"'||'%' OR content LIKE '%'||'"+keyword+"'||'%'";
			
			String user="";
			if(userId!=null) {
				user=" AND user_id='"+userId+"'";
			}
			
			conn=cm.getConnection();
			String sql="SELECT COUNT(*) FROM user_question_3 "
					+ "WHERE group_step=0";
			if(cate==4) {
				sql+=searchCate;
			}
			sql+=user;
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
				vo.setFilesize(rs.getInt(6));
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
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setUserId(rs.getString(2));
			vo.setTitle(rs.getString(3));
			vo.setContent(rs.getString(4));
			if(rs.getString(5)!=null) {
				vo.setFilename(rs.getString(5));
				vo.setFilesize(rs.getInt(6));
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
			String sql="SELECT no, user_id, title, contents, filename,TO_CHAR(create_at,'YYYY-MM-DD HH24:MI:SS'),group_id "
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
			vo.setUpdateAt(rs.getString(6));
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
	
	public void oneDetailAnswerUpdate(OneInquiryVO vo) {
		try {
			conn=cm.getConnection();
			String sql="UPDATE user_question_3 "
					+ "SET contents=?, create_at=sysdate, filename=?, filesize=?"
					+ "WHERE group_id=? AND group_step=1";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getContent());
			ps.setString(2, vo.getFilename());
			ps.setInt(3, vo.getFilesize());
			ps.setInt(4, vo.getGroupId());
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	
	
	public OneInquiryVO oneDetailQuestionUpdateData(int groupId) {
		OneInquiryVO vo = new OneInquiryVO();
		try {
			conn=cm.getConnection();
			String sql="SELECT no, user_id, title, contents, filename, TO_CHAR(create_at,'YYYY-MM-DD HH24:MI:SS'),group_id,secret_check,password "
					+ "FROM user_question_3 "
					+ "WHERE group_step=0 AND group_id=?";
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
			vo.setUpdateAt(rs.getString(6));
			vo.setGroupId(rs.getInt(7));
			vo.setSecretCk(rs.getString(8));
			vo.setPassword(rs.getString(9));
			
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
	
	public void oneDetailQuestionUpdate(OneInquiryVO vo) {
		try {
			conn=cm.getConnection();
			String sql="UPDATE user_question_3 "
					+ "SET title=?, contents=?, create_at=sysdate, filename=?, filesize=? "
					+ "WHERE group_id=? AND group_step=0";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getContent());
			ps.setString(3, vo.getFilename());
			ps.setInt(4, vo.getFilesize());
			ps.setInt(5, vo.getGroupId());
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
