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
	   public List<OrderHistoryVO> orderHistoryListData(int page,String user_id)
	   {
	      List<OrderHistoryVO> ohList=new ArrayList<OrderHistoryVO>();
	      try
	      {
	         conn=cm.getConnection();	         
//	         String sql="SELECT o.*,num "
//	                   +"FROM (SELECT o.*,rownum as num "
//	                         +"FROM (SELECT * "
//	                               +"FROM orders_3 ORDER BY order_id DESC) o"
//	                         +") o "
//	                   +"WHERE num BETWEEN ? AND ?";//1~10 , 11~20
	         
	         String sql="SELECT orderId,title,order_data,payState,totalPrice,num "
	         		+ "FROM (SELECT orderId,title,order_data,payState,totalPrice, rownum as num "
	         		+ "FROM (SELECT o.ORDER_ID as orderId ,b.TITLE as title ,o.order_date as order_data,o.pay_state as payState,o.total_price as totalPrice "
	         		+ "FROM orders_3 o, books_3 b , order_item_3 i,user_3 u "
	         		+ "WHERE b.id=i.book_id  and i.order_id=o.order_id and o.user_id=u.id AND o.USER_ID=? "
	         		+ "ORDER BY o.order_id DESC)) "
	         		+ "WHERE num BETWEEN ? AND ? ";
	         
	         int rowSize=10;
	         int start=(rowSize*page)-(rowSize-1);
	         int end=rowSize*page;
	         
	         ps=conn.prepareStatement(sql);
	         ps.setString(1, user_id);
	         ps.setInt(2, start);
	         ps.setInt(3, end);
	         
	         ResultSet rs=ps.executeQuery();
	         while(rs.next()) {
				   
				   OrderHistoryVO vo=new OrderHistoryVO();
				   
				   vo.setOrder_id(rs.getInt(1));
				   vo.setBookName(rs.getString(2));
				   vo.setOrder_date(rs.getDate(3));
				   vo.setPay_state(rs.getInt(4));//결제여부
				   vo.setTotal_price(rs.getInt(5));
				   
				   ohList.add(vo);
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
	      return ohList;
	   }
	   
	   								       // 근데 장바구니 리스트 구매가 안됨ㅎ
	   //주문내역 상세보기(목록-타이틀 클릭시) //장바구니에서 한번에 구매시 -> 주문번호 하나에 book 여러 개 들어있음..
	   public List<OrderHistoryVO> OrderHistoryDetail(int order_id)
	   {
		   List<OrderHistoryVO> ohList=new ArrayList<OrderHistoryVO>();
//		   PayVO vo=new PayVO();
		   try
		   {
			   conn=cm.getConnection();
//			   String sql="SELECT o.*,(SELECT quantity FROM orders_item_3 WHERE order_id=?) "
//					   +"FROM orders_3 o "
//					   +"WHERE order_id=?";
			   String sql="SELECT o.order_id,b.title,b.poster,b.id "
					  +"o.order_date,o.total_price,o.state,o.pay_state,o.receiver_name,"
					  +"o.ship_address1,o.ship_address2,o.zipcode,o.receiver_phone,o.ship_request,i.quantity"
	         		  + "FROM (SELECT * "
	         		  + "FROM books_3 b LEFT JOIN order_item_3 i ON b.id=i.book_id "
	         		  + "LEFT JOIN orders_3 o ON i.order_id=o.order_id) "
	         		  + "WHERE o.order_id=?";
			  
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, order_id);
			   ResultSet rs=ps.executeQuery();
			   while(rs.next()) {
				   
				   OrderHistoryVO vo=new OrderHistoryVO();
				   
				   vo.setOrder_id(rs.getInt("o.order_id"));
				   vo.setBook_name(rs.getString("b.title"));
				   vo.setPoster(rs.getString("b.poster"));
				   vo.setOrder_date(rs.getDate("o.order_date"));
				   vo.setTotal_price(rs.getInt("o.total_price"));
				   vo.setState(rs.getString("o.state"));//주문완료/취소
				   vo.setPay_state(rs.getInt("o.pay_state"));//결제여부
				   vo.setReceiver_name(rs.getString("o.receiver_name"));
				   vo.setShip_address1(rs.getString("o.ship_address1"));
				   vo.setShip_address2(rs.getString("o.ship_address2"));
				   vo.setZipcode(rs.getString("o.zipcode"));
				   vo.setReceiver_phone(rs.getInt("o.receiver_phone"));
				   vo.setShip_request(rs.getString("o.ship_request"));
				   vo.setQuantity(rs.getInt("i.quantity"));
				   vo.setBook_id(rs.getInt("b.id"));
				   ohList.add(vo);
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
		   return ohList;
	   } 
	   
	 
	   //주문내역=> 총페이지
	   public int orderHistoryTotalPage(String user_id)
	   {
		   int total=0;
		   try
		   {
			   conn=cm.getConnection();
			   String sql="SELECT CEIL(COUNT(*)/10.0) "
					     +"FROM orders_3 "
					     +"WHERE user_id=?";
			   ps=conn.prepareStatement(sql);
			   ps.setString(1, user_id);
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
