package dao;
import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.UserVO;

public class LoginDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ConnectionManager cm = new ConnectionManager();

    // 추후 String => UserVO로 바꾸기
    public String isLogin(String id,String pwd){
        String result="";
        try{
            conn=cm.getConnection();
            String sql="SELECT COUNT(*) FROM user_3 " +
                    "WHERE id=?";
            ps= conn.prepareStatement(sql);
            ps.setString(1,id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close();
            if(count==0){
                result="NOID";
            }else{
                sql="SELECT password,name,admin_check FROM user_3 WHERE id=?";
                ps= conn.prepareStatement(sql);
                ps.setString(1,id);
                rs = ps.executeQuery();
                rs.next();
                String db_pwd=rs.getString(1);
                String name=rs.getString(2);
                String aCheck=rs.getString(3);
                rs.close();
                if(db_pwd.equals(pwd)){
                    result=name+"|"+aCheck;
                    sql="UPDATE user_3 SET login_check='Y' WHERE id=?";
                    ps=conn.prepareStatement(sql);
                    ps.setString(1,id);
                    ps.executeUpdate();
                }else{
                    result="NOPWD";
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(conn,ps);
        }
        return result;
    }
    public void logout(String id){
        try{
            conn=cm.getConnection();
            String sql ="UPDATE user_3 SET login_check='N' WHERE id=?";
            ps= conn.prepareStatement(sql);
            ps.setString(1,id);
            ps.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            cm.disConnection(conn,ps);
        }
    }
    public String memberJoin(UserVO vo)
    {
 	   try
 	   {
 		   conn=cm.getConnection();
 		   String sql="INSERT INTO project_member VALUES(?,?,?,?,?,?,"
 				     +"?,?,?,?,?,?,'n')";
 		   ps=conn.prepareStatement(sql);
 		   ps.setString(1, vo.getId());
 		   ps.setString(2, vo.getPassword());
 		   ps.setString(3, vo.getName());
 		   ps.setDate(4, vo.getBirth());
 		   ps.setString(5, vo.getGender());
 		   ps.setInt(6, vo.getTel());
 		   ps.setString(7, vo.getAddress1());
 		   ps.setString(8, vo.getAddress2());
 		   ps.setInt(9, vo.getPost());
 		   ps.setString(10, vo.getContent());
 		   ps.setString(11, vo.getAdmin());
 		   ps.setString(12, vo.getMsg());
 		   
 		   
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
