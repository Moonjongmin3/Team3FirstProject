package dao;

import Common.*;
import java.util.*;

import java.sql.*;
import vo.BoardReplyVO;

public class BoardReplyDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ConnectionManager cm = new ConnectionManager();
	
	public List<BoardReplyVO> replyListData(int board_no)
	   {
		   List<BoardReplyVO> replyList=new ArrayList<BoardReplyVO>();
		   try
		   {
			   conn=cm.getConnection();
			   String sql="SELECT no,board_no,user_id,content, "
					    +"TO_CHAR(creatred_at,'YYYY-MM-DD HH24:MI:SS') "
						+"FROM reply_3 "
						+"WHERE board_no=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, board_no);
			   ResultSet rs=ps.executeQuery();
			   while(rs.next())
			   {
				   BoardReplyVO vo=new BoardReplyVO();
				   vo.setNo(rs.getInt(1));
				   vo.setBoard_no(rs.getInt(2));
				   vo.setUser_id(rs.getString(3));
				   vo.setContent(rs.getString(4));
				   replyList.add(vo);
			   }
			   rs.close();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   cm.disConnection(conn, ps);
		   }
		   return replyList;
	   }
	
	public void replyInsert(BoardReplyVO vo) {
		try {
			conn=cm.getConnection();
			String sql="INSERT INTO reply_3 VALUES("
				     +"(SELECT NVL(MAX(no)+1,1) FROM reply_3),?,?,?,SYSDATE)";
		   ps=conn.prepareStatement(sql);
		   ps.setInt(1, vo.getBoard_no());
		   ps.setString(2, vo.getUser_id());
		   ps.setString(3, vo.getContent());
		   
		   ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			cm.disConnection(conn, ps);
		}
	}
	
	public void replyUpdate(int no,String content)
	   {
		   try
		   {
			   conn=cm.getConnection();
			   String sql="UPDATE reply_3 SET "
					     +"content=?"
					     +"WHERE no=?";
			   ps=conn.prepareStatement(sql);
			   ps.setString(1, content);
			   ps.setInt(2, no);
			   ps.executeUpdate();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   cm.disConnection(conn, ps);
		   }
	   }
	
	public void replyDelete(int no)
	   {
		   try
		   {
			   conn=cm.getConnection();
			   String sql="DELETE FROM reply_3 "
					     +"WHERE no=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, no);
			   ps.executeUpdate();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   cm.disConnection(conn, ps);
		   }
	   }
}
