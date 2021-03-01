package jdbcsrc;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;

public class ConnectDB {
	public static void main(String[] args) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		/*Connection conn = DriverManager.getConnection(
				                  "jdbc:oracle:thin:@localhost:1521:XE",
				                  "jdbctest", "jdbctest");*/
		Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@xe.cljkqcsbb9ok.ap-northeast-2.rds.amazonaws.com:1521:database",
                "jdbctest", "jdbctest");
		System.out.println(conn.getClass().getName());
		DatabaseMetaData mdata = conn.getMetaData();
		System.out.println(mdata.getClass().getName());
		System.out.println("접속된 DB 서버 : "+
		                        mdata.getDatabaseProductName());
		conn.close();
	}
}
