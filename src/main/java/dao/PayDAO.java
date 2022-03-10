package dao;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import vo.UserVO;
import vo.BookVO;
import vo.*;

public class PayDAO {
   private Connection conn;
   private PreparedStatement ps;
   private ConnectionManager cm=new ConnectionManager();
   

   //배송정보 출력 (default:회원)
   public UserVO orderer_info(String userId){
	   
      UserVO vo=new UserVO();
      try {
    	
    		conn=cm.getConnection();
    		String sql="SELECT name,tel,email,address1,address2,post " //'point' UserVO에 없음
    				+"FROM user_3 "
    				+"WHERE id=?";
    		ps=conn.prepareStatement(sql);
    		ps.setString(1, userId);
    		ResultSet rs=ps.executeQuery();
    		while(rs.next()){//??
    		vo.setName(rs.getString(1));
    		vo.setTel(rs.getInt(2));
    		vo.setEmail(rs.getString(3));
    		vo.setAddress1(rs.getString(4));
    		vo.setAddress2(rs.getString(5));
    		vo.setPost(rs.getInt(6));
    		//vo.setPoint(rs.getInt(6)); // point
    		}
    		rs.close();
   
      }catch(Exception ex){
         ex.printStackTrace();
      }finally {
         cm.disConnection(conn, ps);
      }
      return vo;
   }
  

 //주문정보 insert 
   /*
    * orders_item_3{
    * order_id number
    * book_id number
    * quantity number
    * }
    * 
    * orders_3{
    * order_id
    * user_id
    * receiver_name
    * ship_address1
    * ship_address2
    * zipcode
    * receiver_phone
    * ship_request
    * state
    * pay_state
    * order_date
    * use_point
    * total_price
    * quantity
    * }
    */
   //public int order_insert(String userId , int bid, int qty,String[] orderobj){
	public void order_insert(OrderHistoryVO ohvo){
		
         try {          
        	//orders_item_3테이블에 인서트
             conn=cm.getConnection();
             String sql1="INSERT INTO orders_item_3 "
                   +"VALUES (?,?,?)";
             
             ps=conn.prepareStatement(sql1);
             ps.setInt(1,ohvo.getOrder_id());//order_id
             ps.setInt(2, ohvo.getBook_id());
             ps.setInt(3, ohvo.getQuantity());
             
             ps.executeUpdate();
             
             //orders_3테이블에 인서트
             String sql2="INSERT INTO orders_3 "
                     +"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
             ps=conn.prepareStatement(sql2);
           
             ps.setInt(1,ohvo.getOrder_id());//order_id
             ps.setString(2,ohvo.getUser_id());
             ps.setString(3,ohvo.getReceiver_name());//receiver_name
             ps.setString(4,ohvo.getShip_address1());//ship_address1
             ps.setString(5,ohvo.getShip_address2());//ship_address2
             ps.setString(6,ohvo.getZipcode());//zipcode
             
             ps.setInt(7,ohvo.getReceiver_phone());//receiver_phone
             ps.setString(8,ohvo.getShip_request());//ship_request
//             String state="order";//admin승인->pay로 전환 /주문취소-> cancle로 전환
             ps.setString(9,ohvo.getState());//주문완료 / cancle / 결제완료
             ps.setInt(10,ohvo.getPay_state());//관리자 승인여부_default:0
             ps.setDate(11,(java.sql.Date)ohvo.getOrder_date());//default:sysdate
             int use_point=0;// 사용 point 미구현 -> 일단 0으로
             ps.setInt(12,use_point);//use_point
             ps.setInt(13,ohvo.getTotal_price());//total_price
            
             ps.executeUpdate();
             
         }catch(Exception ex){
            ex.printStackTrace();
         }finally {
            cm.disConnection(conn, ps);
         }      
//         return order_id;
      }
	
   
   
}