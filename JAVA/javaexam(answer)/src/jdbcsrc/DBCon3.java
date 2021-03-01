package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 
public class DBCon3 {
    String driver = "org.mariadb.jdbc.Driver";
    Connection con;
    Statement stmt;
    ResultSet rs;
    // "jdbc:mariadb://172.31.42.212:3306/newsbigdata" ?useUnicode=true&characterEncoding=utf8
    public DBCon3() {
         try {
            Class.forName(driver);
            con = DriverManager.getConnection(
                    "jdbc:mariadb://13.125.37.0:3306/newsbigdata?autoReconnect=true",
                    "news",
                    "big1data!");
            
            if( con != null ) {
                System.out.println("DB 접속 성공");
            }
            
            stmt = con.createStatement();
            System.out.println(stmt);
      
            
            	rs = stmt.executeQuery("select name, writedate, memo from visitor");
            	while(rs.next()) {
            		System.out.println(rs.getString(1)+rs.getString(2)+rs.getString(3));
            	}
            
        } catch (ClassNotFoundException e) { 
            System.out.println("드라이버 로드 실패");
        } catch (SQLException e) {
            System.out.println("DB 접속 실패");
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args){
        new DBCon3();
    }
}

