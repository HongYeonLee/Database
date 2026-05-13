package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
	//ip 확인후 수정합니다.
	private static final String URL = "jdbc:mysql://10.240.179.246:3307/test";  
	private static final String USER = "stdUser";
 	private static final String PASS = "dbdb";

	public DatabaseConnector() {}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASS);
	}
}
