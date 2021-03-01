package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
public class DBCon2 {
    String driver = "org.mariadb.jdbc.Driver";
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;
    // "jdbc:mariadb://172.31.42.212:3306/newsbigdata"
    public DBCon2() {
         try {
            Class.forName(driver);
            con = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/newsbigdata",
                    "news",
                    "big1data!");
            
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
        new DBCon2();
    }
}

