package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ConnectionManager {
    public Connection getConnection()
    {
        Connection conn=null;
        try
        {
            Context init=new InitialContext();
            Context c=(Context)init.lookup("java://comp//env");
            DataSource ds=(DataSource)c.lookup("dbcp_myoracle");
            conn=ds.getConnection();
        }catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return conn;
    }
    public void disConnection(Connection conn, PreparedStatement ps)
    {
        try
        {
            if(ps!=null) ps.close();
            if(conn!=null) conn.close();
        }catch(Exception ex){}
    }
}
