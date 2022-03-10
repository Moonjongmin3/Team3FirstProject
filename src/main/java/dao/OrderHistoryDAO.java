package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import vo.*;
import dao.*;

public class OrderHistoryDAO {
	   private Connection conn;
	   private PreparedStatement ps;
	   private ConnectionManager cm=new ConnectionManager();
	
	 //주문내역 목록 출력
	   public List<PayVO> orderHistoryListData(int page)
	   {
	      List<PayVO> list=new ArrayList<PayVO>();
	      try
	      {
	         conn=cm.getConnection();
	         String sql="SELECT o.*,num "
	                   +"FROM (SELECT o.*,rownum as num "
	                         +"FROM (SELECT * "
	                               +"FROM orders_3 ORDER BY order_date) o"
	                         +") o "
	                   +"WHERE num BETWEEN ? AND ?";//1~10 , 11~20
	         
	         int rowSize=10;
	         int start=(rowSize*page)-(rowSize-1);
	         int end=rowSize*page;
	         
	         ps=conn.prepareStatement(sql);
	         ps.setInt(1, start);
	         ps.setInt(2, end);
	         
	         ResultSet rs=ps.executeQuery();
	         while(rs.next())
	         {
	            PayVO vo=new PayVO();
	            vo.setOrder_id(rs.getInt("order_id"));
	            vo.setBook_id(rs.getInt("book_id"));
	            vo.setUser_id(rs.getString("user_id"));
	            vo.setReceiver_name(rs.getString("receiver_name"));
	            vo.setShip_address1(rs.getString("ship_address1"));
	            vo.setShip_address2(rs.getString("ship_address2"));
	            vo.setZipcode(rs.getString("zipcode"));
	            vo.setReceiver_phone(rs.getString("receiver_phone"));
	            vo.setShip_request(rs.getString("ship_request"));
	            vo.setState(rs.getString("state"));
	            vo.setPay_state(rs.getInt("pay_state"));
	            vo.setOrder_date(rs.getDate("order_date"));
	            vo.setUse_point(rs.getInt("use_point"));
	            vo.setTotal_price(rs.getInt("total_price"));
	            vo.setQuantity(rs.getInt("quantity"));
	            
	            list.add(vo);
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
	      return list;
	   }
	   
	   
	   //주문내역 상세보기(목록-타이틀 클릭시)
	   public PayVO OrderHistoryDetail(int order_id)
	   {
		  
		   PayVO vo=new PayVO();
		   try
		   {
			   conn=cm.getConnection();
			   String sql="SELECT o.*,(SELECT quantity FROM orders_item_3 WHERE order_id=?) "
					   +"FROM orders_3 o "
					   +"WHERE order_id=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, order_id);
			   ps.setInt(2, order_id);
			   ResultSet rs=ps.executeQuery();
			   rs.next();
			   vo.setOrder_id(rs.getInt("order_id"));
	           vo.setBook_id(rs.getInt("book_id"));
	           vo.setUser_id(rs.getString("user_id"));
	           vo.setReceiver_name(rs.getString("receiver_name"));
	           vo.setShip_address1(rs.getString("ship_address1"));
	           vo.setShip_address2(rs.getString("ship_address2"));
	           vo.setZipcode(rs.getString("zipcode"));
	           vo.setReceiver_phone(rs.getString("receiver_phone"));
	           vo.setShip_request(rs.getString("ship_request"));
	           vo.setState(rs.getString("state"));
	           vo.setPay_state(rs.getInt("pay_state"));
	           vo.setOrder_date(rs.getDate("order_date"));
	           vo.setUse_point(rs.getInt("use_point"));
	           vo.setTotal_price(rs.getInt("total_price"));
	           vo.setQuantity(rs.getInt("quantity"));
	           
			   rs.close();
		   }catch(Exception ex)
		   {
			  ex.printStackTrace();   
		   }
		   finally
		   {
			   cm.disConnection(conn, ps);
		   }
		   return vo;
	   } 
	   
	 
	  
	   
	   //주문내역=> 총페이지
	   public int orderHistoryTotalPage()
	   {
		   int total=0;
		   try
		   {
			   conn=cm.getConnection();
			   String sql="SELECT CEIL(COUNT(*)/10.0) "
					     +"FROM orders_3";
			   ps=conn.prepareStatement(sql);
			   ResultSet rs=ps.executeQuery();
			   rs.next();
			   total=rs.getInt(1);
			   rs.close();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   conn=cm.getConnection();
		   }
		   return total;
	   }
	   
	   //주문내역 삭제
	   public void orderHistory_delete(int order_id) {
		     
		   try {
		         conn=cm.getConnection();
		            String sql1="DELETE FROM orders_3 WHERE order_id=?";
		                     
		            ps=conn.prepareStatement(sql1);
		            ps.setInt(1, order_id);
		            ps.executeUpdate();
		            
		            String sql2="DELETE FROM orders_item_3 WHERE order_id=?";
                    
		            ps=conn.prepareStatement(sql2);
		            ps.setInt(1, order_id);
		            ps.executeUpdate();
		            
		         
		      }catch(Exception ex) {
		         ex.printStackTrace();
		      }finally {
		         cm.disConnection(conn, ps);
		      }
		      
		      
		   }
	
}
