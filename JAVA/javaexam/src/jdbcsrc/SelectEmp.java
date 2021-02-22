package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

public class SelectEmp {

	public static void main(String[] args) throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(
				"select emp.ename aa, to_char(sal, '9,999'), to_char(hiredate,'yyyy\"�� \"mm\"�� \"dd\"��\"') from emp");
		boolean b = new Random().nextBoolean();
		if (b) {
			while (rs.next()) {
				System.out.println(rs.getString("aa") + " ������ ������" + rs.getString(2) + "�Դϴ�.");
			}
		} else {
			while (rs.next()) {
				System.out.println(rs.getString(1) + " ������ �Ի�����" + rs.getString(3) + "�Դϴ�.");
			}
		}		
		if (b) {
			ResultSet rs1 = stmt.executeQuery("select concat(ename, concat(concat('������ ������ ' ,to_char(sal, '9,999')), '���Դϴ�.' )) from emp");
			while (rs1.next()) {
				System.out.println(rs1.getString(1) );
			}
		} else {
			ResultSet rs2 = stmt.executeQuery("select concat(ename, concat(concat('������ ' ,to_char(hiredate,'yyyy\"�� \"mm\"�� \"dd\"�Ͽ�\"')), '�Ի��Ͽ����ϴ�.' )) from emp");
			while (rs2.next()) {
				System.out.println(rs2.getString(1));
			}
		}		
	}
}
//[ JDBC �ǽ� 1 ]
//
//�ۼ� Ŭ������ : SelectEmp
//���� ����Ŭ ���� : scott
//
//1. scott �������� �����Ѵ�.
//2. true �� false �������� �����Ѵ�.
//
//3. true �̸�
//   emp ���̺��� ��� �������� �̸��� ����, �� ���� �÷��� �����Ѵ�.
//   ���� �������� ǥ�� ����Ѵ�.
//
//   XXX ������ ������ x,xxx���Դϴ�. 
//   XXX ������ ������ x,xxx���Դϴ�.
//   XXX ������ ������ xx,xxx���Դϴ�.
//         :
//4. false �̸�
//   emp ���̺��� ��� �������� �̸��� �Ի� ��¥, �� ���� �÷��� �����Ѵ�.
//   ���� �������� ǥ�� ����Ѵ�.
//
//   XXX ������ xxxx�� xx�� xx�Ͽ� �Ի��Ͽ����ϴ�. 
//   XXX ������ xxxx�� xx�� xx�Ͽ� �Ի��Ͽ����ϴ�. 
//   XXX ������ xxxx�� xx�� xx�Ͽ� �Ի��Ͽ����ϴ�. 