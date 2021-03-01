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
			System.out.print("�μ��� : ");
			dname = sc.next().toUpperCase();
			
			pstmt1.setString(1, dname);
			rs = pstmt1.executeQuery();
			
			if (rs.next()) {
				System.out.println(dname + " �μ����� �ٹ��ϴ� ������");
				do {
					System.out.println(rs.getString("ENAME"));
				}
				while (rs.next());
			}
			else {
				pstmt2.setString(1, dname);
				rs = pstmt2.executeQuery();
				if (!rs.next())
					System.out.println(dname + " �μ��� �������� �ʾƿ�.");
				else
					System.out.println(dname + " �μ����� �ٹ��ϴ� ������ �����ϴ�.");
			}
			
			System.out.print("����Ϸ��� y �� Y �Է� : ");
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
