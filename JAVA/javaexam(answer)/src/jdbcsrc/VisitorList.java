package jdbcsrc;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
public class VisitorList {
	public static void main(String[] args) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection(
				                  "jdbc:oracle:thin:@localhost:1521:XE",
				                  "jdbctest", "jdbctest");
		Statement stmt = conn.createStatement();
		String sql = "select name, writedate, memo from visitor";
		ResultSet rs = stmt.executeQuery(sql);
		System.out.println(conn.getClass().getName());
		System.out.println(stmt.getClass().getName());
		System.out.println(rs.getClass().getName());
		while(rs.next()) {
			System.out.print(rs.getString("name"));
			System.out.print(rs.getString("writedate"));
			System.out.println(rs.getString("memo"));
		}	
		rs.close();
		stmt.close();
		conn.close();
	}
}




