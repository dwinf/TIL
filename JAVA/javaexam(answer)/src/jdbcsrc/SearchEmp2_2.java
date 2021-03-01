package jdbcsrc;

import java.sql.*;
import java.util.Scanner;

public class SearchEmp2_2 {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		String dname, answer;
		Scanner sc = new Scanner(System.in);
		
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");
		PreparedStatement pstmt1 = conn.prepareStatement("SELECT ENAME FROM EMP E, DEPT D "
				+ "WHERE E.DEPTNO = D.DEPTNO AND DNAME = ?");
		PreparedStatement pstmt2 = conn.prepareStatement("SELECT DNAME FROM DEPT WHERE DNAME = ?");
		ResultSet rs;
		
		while (true) {
			System.out.print("부서명 : ");
			dname = sc.next().toUpperCase();
			
			pstmt1.setString(1, dname);
			rs = pstmt1.executeQuery();
			
			if (rs.next()) {
				System.out.println(dname + " 부서에서 근무하는 직원들");
				do {
					System.out.println(rs.getString("ENAME"));
				}
				while (rs.next());
			}
			else {
				pstmt2.setString(1, dname);
				rs = pstmt2.executeQuery();
				if (!rs.next())
					System.out.println(dname + " 부서는 존재하지 않아요.");
				else
					System.out.println(dname + " 부서에서 근무하는 직원이 없습니다.");
			}
			
			System.out.print("계속하려면 y 나 Y 입력 : ");
			answer = sc.next().toUpperCase();
			if (!answer.equals("Y")) break;
		}
		
		sc.close();
		rs.close();
		pstmt1.close();
		pstmt2.close();
		conn.close();
	}

}
