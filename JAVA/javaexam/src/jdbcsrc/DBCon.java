package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
public class DBCon {
    String driver = "org.mariadb.jdbc.Driver";
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;
    // "jdbc:mariadb://172.31.42.212:3306/newsbigdata"
    public DBCon() {
         try {
            Class.forName(driver);
            // "jdbc:mariadb:///13.125.37.0:3306/newsbigdata",
            
            con = DriverManager.getConnection(
                    "jdbc:mariadb://70.12.113.181:3306/lostfind",
                    "root",
                    "password");
            
            if( con != null ) {
                System.out.println("DB 접속 성공");
            }
            
        } catch (ClassNotFoundException e) { 
            System.out.println("드라이버 로드 실패");
        } catch (SQLException e) {
            System.out.println("DB 접속 실패");
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args){
        new DBCon();
    }
}

