import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Main {

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
//		String url = "jdbc:mysql://127.0.0.1:3306/madangdb";
//		String username = "root";
//		String password = "Zxcvbn4657@";
//		try (Connection conn = DriverManager.getConnection(url, username, password)){
//		System.out.println("DB 연결 성공!");
//		
//		// SELECT 예
//		String selectSql = "SELECT * FROM customer";
//		try (Statement stmt = conn.createStatement();
//			ResultSet rs = stmt.executeQuery(selectSql)) {
//				while (rs.next()) {
//					int custid = rs.getInt("custid");
//					String name = rs.getString("name");
//					String address = rs.getString("address");
//					String phone = rs.getString("phone");
//					
//					System.out.printf(" 고객번호: %s, 이름: %s, 주소: %s, 전화번호: %s \n", custid, name, address, phone);
//				}
//			}
//		// INSERT 예
//		String insertSQL = "INSERT INTO customer (custid, name, address, phone) VALUES (?, ?, ?, ?)";
//		try (PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {
//			pstmt.setInt(1, 6);
//			pstmt.setString(2, "jvbc 테스트");
//			pstmt.setString(3, "서울특별시 서대문구 이화여대");
//			pstmt.setString(4, "010-1234-0563");
//			pstmt.executeUpdate();
//			System.out.println("학생 정보 삽입 성공");
//			
//		}
//		
//	} catch (SQLException e) {
//		e.printStackTrace();
//	}
		
		String url = "jdbc:mysql://10.240.179.246:3307/test";
		String username = "stdUser";
		String password = "dbdb";
		
		//try 리소스 문
		try(Connection conn = DriverManager.getConnection(url, username, password)) {
			//사용할 코드
			System.out.println("DB연결 성공!!");
			
			String selectSql = "Select * from student";
			
			try(Statement stmt =  conn.createStatement();){
				ResultSet rs = stmt.executeQuery(selectSql);
				
				//속성을 읽는 순서는 상관없는데 속성의 이름은 중요함
				while(rs.next()) {
					int no = rs.getInt("no"); //필드명이 no인 값을 int로 받아서 no에 저장
					String dept = rs.getString("dept");
					String stdId = rs.getString("stdId");
					String name = rs.getString("name");
					
					System.out.printf("no: %d dept: %s id: %s name: %s \n", no, dept, stdId, name);
				}
			}
		
		}

	}

}
