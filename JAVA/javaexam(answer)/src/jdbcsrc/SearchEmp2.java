package jdbcsrc;

import java.sql.*;
import java.util.Scanner;

public class SearchEmp2 {

	public static void main(String[] args) throws Exception {
		Scanner in = new Scanner(System.in);
		String dname;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");
		PreparedStatement pstmt = conn.prepareStatement(
				"select ename, deptno " + "from emp E RIGHT JOIN DEPT D USING(DEPTNO) " + "WHERE DNAME = UPPER(?)");
		ResultSet rs = null;
		while (true) {
			System.out.print("검색할 부서 이름: ");
			dname = in.next();
			pstmt.setString(1, dname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1) == null) {
					System.out.println(dname+" 부서에서 근무하는 직원이 없습니다.");
				} else {
					System.out.println(dname + " 부서에서 근무하는 직원들");
					do {
						System.out.println(rs.getString(1));
					} while (rs.next());
				}
			} else
				System.out.println(dname + " 부서는 존재하지 않습니다.");

			System.out.println("계속 검토하시겠습니까?(아니요: n) ");

			if (in.next().equals("n"))
				break;
		}
	}

}
