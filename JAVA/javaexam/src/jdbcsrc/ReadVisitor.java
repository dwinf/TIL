package jdbcsrc;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
public class ReadVisitor {
	public static void main(String[] args) throws Exception{
		//1. JDBC Driver 로딩 - Class.forName()
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2. DBMS 에 접속 - DriverManager.getConnection("jdbc url", "계정", "암호")
		/*Connection conn = DriverManager.getConnection(
				                  "jdbc:oracle:thin:@localhost:1521:XE", 
				                  "jdbctest", "jdbctest");*/
		Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@xe.cljkqcsbb9ok.ap-northeast-2.rds.amazonaws.com:1521:database", 
                "jdbctest", "jdbctest");
		System.out.println(conn);
		//3. Statement/PreparedStatement 객체 생성
		Statement stmt = conn.createStatement();
		//4. 처리하려는 기능에 따라서 SQL 문을 전달하고 수행시킨다.
		String sql = "select name, writedate, memo from visitor";
		ResultSet rs = stmt.executeQuery(sql);
		//5. 결과 처리
		while(rs.next()) {
			System.out.println(rs.getString("name")+":"+
					 rs.getDate("writedate")+":"+rs.getString("memo"));
		}
		System.out.println("-----------------끝-----");
		rs.close();
		stmt.close();
		conn.close();
	}
}








