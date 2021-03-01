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
				System.out.println(rs.getString(1)+ ":::"+rs.getString(2) + " 직원의 월급은" + rs.getString(2) + "입니다.");
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