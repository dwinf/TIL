package jdbcsrc;

import java.sql.*;

public class JDBC_Test {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		kaja("E");
	}

	public static void kaja(String fn) {
		String sql = "SELECT FIRST_NAME, LAST_NAME, TO_CHAR(SALARY, '999,999')||'원' 급여 "
				+ "FROM EMPLOYEES WHERE FIRST_NAME LIKE 'E%'";
		String sql2 = "Select first_name, last_name, salary from employees where upper(first_name) like '%E%' ";
		try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@70.12.115.180:1521:XE", "hr", "hr");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql2);) {
			String output = null;
			if (rs.next()) {
				do {
					output = String.format("%s(%s) %s원", rs.getString("FIRST_NAME"), rs.getString("LAST_NAME"), rs.getString("SALARY"));
//					System.out.print(rs.getString("FIRST_NAME") + "\t");
//					System.out.print(rs.getString("LAST_NAME") + "\t");
//					System.out.print(rs.getString("SALARY"));
//					System.out.println();
					System.out.println(output);
				} while (rs.next());
			}
//          output = String.format("%s(%s) %s원", res.getString("first_name"), res.getString("last_name"), res.getString("salary"));
			System.out.println("dddd");
		} catch (SQLException e) {
			//System.out.printf("DB연동 오류 발생 : %s", e);
			e.printStackTrace();
		}
		System.out.println("aaaadd");

	}

}

//
//package jdbcsrc;
//import java.sql.*;
//public class JDBC_Test {
//
//   public static void main(String[] args)throws SQLException, ClassNotFoundException{
//      Class.forName("oracle.jdbc.driver.OracleDriver");
//      kaja("E");
//   }
//   public static void kaja(String fn) {
//
//      try(Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "hr", "hr");
//         Statement stmt = conn.createStatement();
//         ResultSet res = stmt.executeQuery("Select first_name, last_name, salary from employees where upper(first_name) like 'E%' ");){
//         String output = "";
//         
//         while(res.next()) {
//            output = String.format("%s(%s) %s원", res.getString("first_name"), res.getString("last_name"), res.getString("salary"));
//            
//            System.out.println(output);
//         }
//         
//      }
//      catch(Exception e) {
//         System.err.println("DB연동 오류 발생 : " + e);
//      }
//   }
//}
//   