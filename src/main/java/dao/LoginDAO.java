package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
