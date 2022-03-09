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
   
//   //상품정보 출력->BookDAO_bookfind() // 일단 보류
//   public List<BookVO> book_info(int bid,int qty) {
//	  List<BookVO> vo=new ArrayList<BookVO>();
//      BookVO vo=new BookVO();
//      try {
//         conn=cm.getConnection();
//            String sql="SELECT poster,category_id,title,author,price,salerate "
//                     +"FROM books_3 "
//                     +"WHERE id=?";
//            ps=conn.prepareStatement(sql);
//            ps.setInt(1, bid);
//            ResultSet rs=ps.executeQuery();
//            rs.next();
//            	vo.setPoster(rs.getString(1));
//            	vo.setName(rs.getString(3));
//            	vo.setAuthor(rs.getString(4));
//            	vo.setPrice(rs.getInt(5));
//            	vo.setSaleRate(rs.getInt(6));
//            	//MainCategory
//            	int cate_id=rs.getInt(2);
//            	String cid=null;
//            	if(cate_id==1) {
//            		cid="국내도서";
//            	}else  if(cate_id==2) {
//            		cid="외국도서";
//            	}else  if(cate_id==3) {
//            		cid="eBook";
//            	}
//            	vo.setMainCategory(cid);
//            rs.close();
//         
//      }catch(Exception ex) {
//         ex.printStackTrace();
//      }finally {
//         cm.disConnection(conn, ps);
//      }
//      return list;
//      
//   }
   //qty인서트
//   public void insertQty(int qty , String id ) {
//	  
//   }
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
    		rs.next();//??
    		vo.setName(rs.getString(1));
    		vo.setTel(rs.getInt(2));
    		vo.setEmail(rs.getString(3));
    		vo.setAddress1(rs.getString(4));
    		vo.setAddress2(rs.getString(5));
    		//vo.setPoint(rs.getInt(6)); // point
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
   
	public void order_insert(String userId , int bid, int qty,String[] orderobj){
		Date today=new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String Today=sdf.format(new Date()).toString();
      	PayVO vo=new PayVO();
         try {          
        	//orders_item_3테이블에 인서트
             conn=cm.getConnection();
             String sql1="INSERT INTO orders_item_3 "
                   +"VALUES (?,?,?)";
             
             ps=conn.prepareStatement(sql1);
             ps.setInt(1,Integer.parseInt(Today+orderobj[5]+orderobj[6]));//order_id
             ps.setInt(2, bid);
             ps.setInt(3, qty);
             
             ps.executeUpdate();
             
             //orders_3테이블에 인서트
             String sql2="INSERT INTO orders_3 "
                     +"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
             ps=conn.prepareStatement(sql2);
           
             ps.setInt(1,Integer.parseInt(Today+orderobj[5]+orderobj[6]));//order_id
             ps.setString(2,userId);
             ps.setString(3,orderobj[0]);//receiver_name
             ps.setString(4,orderobj[1]);//ship_address1
             ps.setString(5,orderobj[2]);//ship_address2
             ps.setString(6,orderobj[3]);//zipcode
             int receiver_phone=Integer.parseInt(orderobj[4]+orderobj[5]+orderobj[6]);
             ps.setInt(7,receiver_phone);//receiver_phone
             ps.setString(8,orderobj[7]);//ship_request
             String state="order";//admin승인->pay로 전환 /주문취소-> cancle로 전환
             ps.setString(9,state);//order / cancle / pay
//           ps.setString(10,pay_state);//default:0
//           ps.setString(11,order_date);//default:sysdate
             int use_point=0;// 사용 point 미구현 -> 일단 0으로
             ps.setInt(12,use_point);//use_point
             ps.setInt(13,Integer.parseInt(orderobj[8]));//total_price
            
             ps.executeUpdate();
             
         }catch(Exception ex){
            ex.printStackTrace();
         }finally {
            cm.disConnection(conn, ps);
         }        
      }
   
   
}