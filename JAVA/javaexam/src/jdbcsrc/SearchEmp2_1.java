package jdbcsrc;

import java.sql.*;
import java.util.*;

public class SearchEmp2_1 {

	public static void main(String[] args) {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("OracleDriver 접속 완료");
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String sql = "SELECT ENAME "
						+ "FROM EMP JOIN DEPT USING(DEPTNO) "
						+ "WHERE DNAME = ?";
		
		try ( Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");
				PreparedStatement pstmt = conn.prepareStatement(sql);
				Scanner sc = new Scanner(System.in);) {
			
			System.out.println("Scott 계정 접속 완료");
			
			String dName;
			boolean check = true;
			
			do {
				System.out.print("\n검색할 부서 이름을 입력하십시오 : ");
			
				dName = sc.nextLine().toUpperCase();
				pstmt.setString(1,  dName);
				
				try (ResultSet rs = pstmt.executeQuery()){
					//데이터가 검색되는 경우
					if(rs.next()) {
						System.out.println(dName + " 부서에서 근무하는 직원들");
						do {
							System.out.println("\t" + rs.getString(1));
						} while(rs.next());
					}
					//데이터 검색이 안 되는 경우
					else {
						String re_sql = "SELECT DNAME "
											+ "FROM DEPT "
											+ "WHERE DNAME = '"+ dName + "'";
						
						try(	Statement re_stmt = conn.createStatement();
								ResultSet re_rs = re_stmt.executeQuery(re_sql)){
							//부서가 검색되는 경우
							if(re_rs.next())
								System.out.println(dName + "부서에서 근무하는 직원이 없습니다.");
							//부서가 없는 경우
							else
								System.out.println(dName + "부서는 존재하지 않아요.");
						}
						catch(SQLException e) {
							e.printStackTrace();
						}
					}
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				
				System.out.print("\n계속 검색하려면 Y 입력(그 외엔 종료) : ");
				if(!"Y".equals(sc.nextLine().toUpperCase()))
					check = false;
			
			} while(check);
			
		}
		catch (SQLException e){
			e.printStackTrace();
		}
		
		System.out.println("시스템 종료");
	}

}
