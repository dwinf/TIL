package jdbcsrc;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
public class ReadVisitor2 {
	public static void main(String[] args) throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(
				                  "jdbc:oracle:thin:@localhost:1521:XE", 
				                  "jdbctest", "jdbctest");
		Statement stmt = conn.createStatement();
		Scanner scan = new Scanner(System.in);
		System.out.print("검색할 이름을 입력하세요 : ");
		String searchName = scan.nextLine();
		scan.close();
		String sql = "select name, writedate, memo from visitor " +
		                          "where name = '"+searchName+"'";
		ResultSet rs = stmt.executeQuery(sql);	
		if(rs.next()) {
			System.out.println(rs.getString("name")+":"+
					 rs.getDate("writedate")+":"+rs.getString("memo"));
		} else {
			System.out.println(searchName+"님이 작성한 글이 없습니다.");
		}
		System.out.println("-----------------끝-----");
		rs.close();
		stmt.close();
		conn.close();
	}
}








