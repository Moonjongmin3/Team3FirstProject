package dao;
import Common.*;
import vo.NoticeVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NoticeDAO{
    private Connection con;
    private PreparedStatement psmt;
    private ConnectionManager cm = new ConnectionManager();

    public List<NoticeVO> noticeList(int page,String cate,String Keyword){
        List<NoticeVO> list = new ArrayList<>();
        try{
//            제목+내용 아직 구현 못함...
            con=cm.getConnection();
            String sql="SELECT no,title,created_at,num " +
                    "FROM (SELECT no,title,created_at,rownum as num " +
                    "FROM (SELECT no,title,created_at FROM notice_3 " +
                    "WHERE "+cate+" LIKE '%'||?||'%' "+
                    "order by no DESC)) " +
                    "WHERE num between ? and ?";
            int rowSize=10;
            int start=(rowSize*page)-(rowSize-1);
            int end=rowSize*page;
            psmt =con.prepareStatement(sql);


            psmt.setString(1,Keyword);
            psmt.setInt(2,start);
            psmt.setInt(3,end);
            ResultSet rs = psmt.executeQuery();
            while (rs.next()){
                NoticeVO vo = new NoticeVO();
                vo.setNo(rs.getInt(1));
                vo.setTitle(rs.getString(2));
                vo.setCreated_At(rs.getDate(3));
                list.add(vo);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
        return list;
    }

    public int totalCount(String cate,String keyword){
        int total=0;
        try{
        	con=cm.getConnection();
            String sql="SELECT CEIL(COUNT(*)/10.0) FROM notice_3 " +
                    "WHERE "+cate+" LIKE '%'||?||'%' ";
            psmt=con.prepareStatement(sql);
            psmt.setString(1,keyword);
            ResultSet rs=psmt.executeQuery();
            rs.next();
            total=rs.getInt(1);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
        return total;
    }
    
    public void noticeInsertData(NoticeVO vo) {
    	try {
    		con=cm.getConnection();
    		String sql="INSERT INTO notice_3 (no,admin_id,title,content,created_at,hit) VALUES " +
                    "((SELECT NVL(MAX(no)+1,1) FROM notice_3),?,?,?,sysdate,0)";
    		psmt=con.prepareStatement(sql);
            psmt.setString(1,vo.getAdminID());
            psmt.setString(2,vo.getTitle());
            psmt.setString(3,vo.getContent());
            psmt.executeUpdate();

    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
			cm.disConnection(con, psmt);
		}
    	
    }

    public NoticeVO noticeDetailData(int no){
        NoticeVO vo = new NoticeVO();
        try {
            con=cm.getConnection();
            String sql ="UPDATE notice_3 SET " +
                    "hit=hit+1 "+
                    "WHERE no=?";
            psmt= con.prepareStatement(sql);
            psmt.setInt(1,no);
            //실행
            psmt.executeUpdate(); // commit()가 포함

            sql="SELECT no,title,content,created_at,hit " +
                    "FROM notice_3 " +
                    "WHERE no=?";
            psmt=con.prepareStatement(sql);
            psmt.setInt(1,no);
            ResultSet rs = psmt.executeQuery();
            rs.next();
            vo.setNo(rs.getInt(1));
            vo.setTitle(rs.getString(2));
            vo.setContent(rs.getString(3));
            vo.setCreated_At(rs.getDate(4));
            vo.setHit(rs.getInt(5));

            rs.close();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
        return vo;
    }

    public NoticeVO noticeUpdateData(int no){
        NoticeVO vo = new NoticeVO();
        try{
            con=cm.getConnection();
            String sql = "SELECT no,title,content " +
                    "FROM notice_3 " +
                    "WHERE no=?";
            psmt= con.prepareStatement(sql);
            psmt.setInt(1,no);
            ResultSet rs = psmt.executeQuery();
            rs.next();
            vo.setNo(rs.getInt(1));
            vo.setTitle(rs.getString(2));
            vo.setContent(rs.getString(3));

            rs.close();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
        return vo;
    }

    public void noticeUpdate(NoticeVO vo){
        try{
            con=cm.getConnection();
//          추후 updated_at이 필요없다 판단되면 created_at=sysdate로 변경
            String sql="UPDATE notice_3 SET title=?,content=?,admin_id=?,updated_at=sysdate " +
                    "WHERE no=?";
            psmt=con.prepareStatement(sql);
            psmt.setString(1,vo.getTitle());
            psmt.setString(2,vo.getContent());
            psmt.setString(3,vo.getAdminID());
            psmt.setInt(4,vo.getNo());
            psmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
    }

    public void noticeDelete(int no){
        try{
            con=cm.getConnection();
            String sql ="DELETE FROM notice_3 WHERE no=?";
            psmt=con.prepareStatement(sql);
            psmt.setInt(1,no);
            psmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
    }

    public List<NoticeVO> noticeSearchData(String search_cate, String search, int page){
        List<NoticeVO> list = new ArrayList<>();
        try{
            con=cm.getConnection();
            String sql="SELECT no,title,created_at,num " +
                    "FROM (SELECT no,title,created_at,rownum as num " +
                    "FROM (SELECT no,title,created_at FROM notice_3 " +
                    "WHERE ? LIKE '%'||?||'%'"+
                    "order by no DESC)) " +
                    "WHERE num between ? and ?";
            int rowNum=10;
            int start=(rowNum*page)-(rowNum-1);
            int end=rowNum*page;
            psmt=con.prepareStatement(sql);
            psmt.setString(1,search_cate);
            psmt.setString(2,search);
            psmt.setInt(3,start);
            psmt.setInt(4,end);
            ResultSet rs= psmt.executeQuery();
            while(rs.next()){
                NoticeVO vo = new NoticeVO();
                vo.setNo(rs.getInt(1));
                vo.setTitle(rs.getString(2));
                vo.setCreated_At(rs.getDate(3));

                list.add(vo);
            }
            rs.close();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }
        return list;
    }
}
