package dao;

import java.sql.*;
import java.util.*;
import vo.UserVO;
import vo.BookVO;

public class PayDAO {
   private Connection conn;
   private PreparedStatement ps;
   private ConnectionManager cm=new ConnectionManager();
   
   //상품정보 출력
   public BookVO book_info(int bid) {
      BookVO vo=new BookVO();
      try {
         conn=cm.getConnection();
            String sql="SELECT poster,category_id,title,author,price,salerate "
                     +"FROM books_3 "
                     +"WHERE id=?";
            ps=conn.prepareStatement(sql);
            ps.setInt(1, bid);
            ResultSet rs=ps.executeQuery();
            
            vo.setPoster(rs.getString(1));
            vo.setName(rs.getString(3));
            vo.setAuthor(rs.getString(4));
            vo.setPrice(rs.getInt(5));
            vo.setSaleRate(rs.getInt(6));
            //MainCategory
            int cate_id=rs.getInt(2);
            String cid=null;
            if(cate_id==1) {
               cid="국내도서";
            }else  if(cate_id==2) {
               cid="외국도서";
            }else  if(cate_id==3) {
               cid="eBook";
            }
            vo.setMainCategory(cid);
            
            rs.close();
         
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         cm.disConnection(conn, ps);
      }
      return vo;
      
   }
   //배송정보 출력 (default:회원)
   public UserVO orderer_info(String userId){
	   
      UserVO vo=new UserVO();
      try {
    	if(userId!=null) {
    		conn=cm.getConnection();
    		String sql="SELECT name,phone_number,email,address1,address2 " //'point' UserVO에 없음
    				+"FROM user_3 "
    				+"WHERE id=?";
    		ps=conn.prepareStatement(sql);
    		ps.setString(1, userId);
    		ResultSet rs=ps.executeQuery();
    		
    		while(rs.next()) {
    			vo.setName(rs.getString(1));
    			vo.setTel(rs.getInt(2));
    			vo.setEmail(rs.getString(3));
    			vo.setAddress1(rs.getString(4));
    			vo.setAddress2(rs.getString(5));
    			//vo.setPoint(rs.getInt(6)); // point    			
    		}
    		rs.close();
    	}else {//비회원
    			vo=null;
    	}
         
      }catch(Exception ex){
         ex.printStackTrace();
      }finally {
         cm.disConnection(conn, ps);
      }
      return vo;
   }
   //주문정보 insert 
   
   //PayVO '주문내역페이지'에 출력
   
   
}