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
				"select emp.ename aa, to_char(sal, '9,999'), to_char(hiredate,'yyyy\"년 \"mm\"월 \"dd\"일\"') from emp");
		boolean b = new Random().nextBoolean();
		if (b) {
			while (rs.next()) {
				System.out.println(rs.getString("aa") + " 직원의 월급은" + rs.getString(2) + "입니다.");
			}
		} else {
			while (rs.next()) {
				System.out.println(rs.getString(1) + " 직원의 입사일은" + rs.getString(3) + "입니다.");
			}
		}		
		if (b) {
			ResultSet rs1 = stmt.executeQuery("select concat(ename, concat(concat('직원의 월급은 ' ,to_char(sal, '9,999')), '원입니다.' )) from emp");
			while (rs1.next()) {
				System.out.println(rs1.getString(1) );
			}
		} else {
			ResultSet rs2 = stmt.executeQuery("select concat(ename, concat(concat('직원은 ' ,to_char(hiredate,'yyyy\"년 \"mm\"월 \"dd\"일에\"')), '입사하였습니다.' )) from emp");
			while (rs2.next()) {
				System.out.println(rs2.getString(1));
			}
		}		
	}
}
//[ JDBC 실습 1 ]
//
//작성 클래스명 : SelectEmp
//접속 오라클 계정 : scott
//
//1. scott 계정으로 접속한다.
//2. true 와 false 랜덤값을 추출한다.
//
//3. true 이면
//   emp 테이블에서 모든 직원들의 이름과 월급, 두 개의 컬럼을 추출한다.
//   다음 형식으로 표준 출력한다.
//
//   XXX 직원의 월급은 x,xxx원입니다. 
//   XXX 직원의 월급은 x,xxx원입니다.
//   XXX 직원의 월급은 xx,xxx원입니다.
//         :
//4. false 이면
//   emp 테이블에서 모든 직원들의 이름과 입사 날짜, 두 개의 컬럼을 추출한다.
//   다음 형식으로 표준 출력한다.
//
//   XXX 직원은 xxxx년 xx월 xx일에 입사하였습니다. 
//   XXX 직원은 xxxx년 xx월 xx일에 입사하였습니다. 
//   XXX 직원은 xxxx년 xx월 xx일에 입사하였습니다. 