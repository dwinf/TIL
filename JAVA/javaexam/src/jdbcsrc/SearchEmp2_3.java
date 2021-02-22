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
				System.out.print("�˻��� ������ �μ����� �Է��ϼ��� : ");
				String dn = sc.next().toUpperCase();				
				ResultSet rs = stmt.executeQuery("select ename from emp e natural join dept d where d.dname='"+dn+"'");
				if(rs.next()) {
					System.out.println(dn + "�μ����� �ٹ��ϴ� ������");
					do {
						System.out.println(rs.getString(1));
					} while(rs.next());
				} else {
					ResultSet st1 = stmt.executeQuery("select dname from dept where dname='"+dn+"'");
					if(st1.next()) {
						System.out.println(dn + "�μ����� �ٹ��ϴ� ������ �����ϴ�.");
					} else {
						System.out.println(dn + "�μ��� �������� �ʽ��ϴ�.");
					}
				}
				System.out.print("���(Y) | ����(N) : ");
				dn = sc.next().toUpperCase();
				if(dn.equals("N")) {
					bl = false;
					System.out.println("�˻� ����");
				}
			}		
			sc.close();
			stmt.close();
			conn.close();
	}
}
