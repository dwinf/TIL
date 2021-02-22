package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

public class SelectEmp2 {

	public static void main(String[] args) throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");
		PreparedStatement stmt = conn.prepareStatement("select ename, sal, hiredate from emp where sal > ?*1000");
		stmt.setInt(1, 3);
		ResultSet rs = stmt.executeQuery();
		boolean b = new Random().nextBoolean();
		if (true) {
			while (rs.next()) {
				System.out.println(rs.getString(1)+ ":::"+rs.getString(2) + " ������ ������" + rs.getString(2) + "�Դϴ�.");
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