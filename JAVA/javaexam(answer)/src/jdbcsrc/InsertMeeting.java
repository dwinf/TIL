package jdbcsrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Scanner;

public class InsertMeeting {
	public static void main(String[] args) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		Scanner sc1 = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "jdbctest", "jdbctest");
			pstmt = conn.prepareStatement("INSERT into meeting values(meeting_seq.nextval, ?, ?, ?)");
			sc1 = new Scanner(System.in);
			System.out.print("이름 : ");
			String name = sc1.nextLine();
			System.out.print("타이틀을 입력하세요 : ");
			String text = sc1.nextLine();
			System.out.print("시간입력 (yyyy mm dd hh mi) :");
			String date = sc1.nextLine();

			pstmt.setString(1, name);
			pstmt.setString(2, text);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy MM dd HH mm");
			java.util.Date d = sdf.parse(date);
			pstmt.setDate(3, new java.sql.Date(d.getTime()));
			pstmt.executeUpdate();
			System.out.println("데이터 저장 성공");
		} catch (ParseException pe) {
			pe.printStackTrace();
			System.out.println("파싱 오류");
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
			System.out.println("드라이버 로딩 오류");
		} catch (SQLException se) {
			se.printStackTrace();
			System.out.println("데이터 저장 실패");
		} finally {
			try {
				if (sc1 != null)
					sc1.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}

	}

}
