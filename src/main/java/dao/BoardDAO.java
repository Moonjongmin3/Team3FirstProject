package dao;

import Common.*;
import vo.BoardVO;
import java.sql.*;
import java.util.*;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ConnectionManager cm;
	
	public List<BoardVO> boardList(int page){
		List<BoardVO> list=new ArrayList<BoardVO>();
		try {
			conn=ps.getConnection();
			String sql="SELECT no,user_id,title,created_at,hit,num"
						+"FROM (SELECT no,user_id,title,created_at,hit,rownum as num"
						+"FROM (SELECT no,user_id,title,created_at,hit"
						+"FROM board_3 ORDER BY no DESC))"
						+"WHERE num BETWEEN ? AND ?";
			int rowSize=10;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BoardVO vo=new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setUser_id(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setCreated_at(rs.getDate(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
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
	
	// 총페이지
	public int boardTotalPage() {
		int total=0;
		try {
			cm.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM board_3";
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
	
	//글쓰기
	public void boardInsert(BoardVO vo) {
		try {
			cm.getConnection();
			String sql="INSERT INTO board_3(no,user_id,title,content,bfile,pwd)"
					+"VALUES ((SELECT NVL(MAX(no)+1,1) FROM Board_3),?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getUser_id());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getBfile());
			ps.setString(5, vo.getPwd());
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	
	//상세보기
	public BoardVO boardDetailData(int no) {
		BoardVO vo=new BoardVO();
		try {
			//조회수 증가
			cm.getConnection();
			String sql="UPDATE board_3"
					 +"SET hit=hit+1"
					 +"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.executeUpdate();
			
			//상세 게시물 가져오기
			sql="SELECT no,user_id,title,content,created_at,bfile,hit"
					+"FROM board_3"
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setUser_id(rs.getString(2));
			vo.setTitle(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setCreated_at(rs.getDate(5));
			vo.setBfile(rs.getString(6));
			vo.setHit(rs.getInt(7));
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
	
	public BoardVO boardUpdateDate(int no) {
		BoardVO vo=new BoardVO();
		try {
			conn=cm.getConnection();
			String sql="SELECT no,title,content"
					+"FROM board_3"
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setTitle(rs.getString(2));
			vo.setContent(rs.getString(3));
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
	
	public boolean boardUpdate(BoardVO vo) {
		boolean bCheck=false;
		try {
			cm.getConnection();
			String sql="SELECT pwd FROM board_3"
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getNo());
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			
			if(db_pwd.equals(vo.getPwd())) {
				sql="UPDATE board_3" 
						+"SET title=?,content=?,created_at=sysdate,bfile=?,pwd=?"
						+"WHERE no=?";
				ps.setString(1, vo.getTitle());
				ps.setString(2, vo.getContent());
				ps.setString(3, vo.getBfile());
				ps.setString(4, vo.getPwd());
				ps.setInt(5, vo.getNo());
				ps.executeUpdate();				
			}
			else {
				bCheck=false;
			}
			
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		return bCheck;
	}
	
	
	public boolean boardDelete(int no,String pwd) {
		boolean bCheck=false;
		try {
			cm.getConnection();
			String sql="SELECT pwd FROM board_3"
						+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			if(db_pwd.equals(pwd)) {
				bCheck=true;
				sql="DELETE FROM board_3 WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, no);
				ps.executeUpdate();
			}
			else {
				bCheck=false;
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
		
		return bCheck;
	}
	
	public List<BoardVO> boardFind(String fs,String ss,int page){
		List<BoardVO> list=new ArrayList<>();
		try {
			conn=cm.getConnection();
			String sql="SELECT no,user_id,title,created_at,hit"
					+"FROM board_3"
					+"WHERE ? LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, fs);
			ps.setString(2, ss);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BoardVO vo=new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setUser_id(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setCreated_at(rs.getDate(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
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
}