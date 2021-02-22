package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class SearchEmp2_3 {
	public static void main(String[] args) throws Exception {
			Class.forName("oracle.jdbc.driver.OracleDriver");		
			Scanner sc = new Scanner(System.in);		
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");
			Statement stmt = conn.createStatement();
			boolean bl = true;
			while(bl) {
				System.out.print("검색할 직원의 부서명을 입력하세요 : ");
				String dn = sc.next().toUpperCase();				
				ResultSet rs = stmt.executeQuery("select ename from emp e natural join dept d where d.dname='"+dn+"'");
				if(rs.next()) {
					System.out.println(dn + "부서에서 근무하는 직원들");
					do {
						System.out.println(rs.getString(1));
					} while(rs.next());
				} else {
					ResultSet st1 = stmt.executeQuery("select dname from dept where dname='"+dn+"'");
					if(st1.next()) {
						System.out.println(dn + "부서에서 근무하는 직원이 없습니다.");
					} else {
						System.out.println(dn + "부서는 존재하지 않습니다.");
					}
				}
				System.out.print("계속(Y) | 종료(N) : ");
				dn = sc.next().toUpperCase();
				if(dn.equals("N")) {
					bl = false;
					System.out.println("검색 종료");
				}
			}		
			sc.close();
			stmt.close();
			conn.close();
	}
}
