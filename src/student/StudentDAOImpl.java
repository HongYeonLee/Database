package student;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentDAOImpl implements StudentDAO {
	private Connection conn;
    
    public StudentDAOImpl() {
    }
    
    public StudentDAOImpl(Connection conn) {
		this.conn = conn;
    }

    public List<Student> findAll() {
    	String sql = "SELECT * FROM student";
    	List<Student> stdList = new ArrayList<>();
        
        try(
        		PreparedStatement ps = conn.prepareStatement(sql);
        		ResultSet rs = ps.executeQuery()
        ){
	        // 결과 매핑 후 반환
			//속성을 읽는 순서는 상관없는데 속성의 이름은 중요함
			while(rs.next()) {
				int no = rs.getInt("no"); //필드명이 no인 값을 int로 받아서 no에 저장
				String dept = rs.getString("dept");
				String stdId = rs.getString("stdId");
				String name = rs.getString("name");
				System.out.printf("no: %d dept: %s id: %s name: %s \n", no, dept, stdId, name);
				
				Student s = new Student();
				s.setNo(no);
				s.setDept(dept);
				s.setStdID(stdId);
				s.setName(name);
				
				stdList.add(s);
			}
        } catch(SQLException e) {
        	e.printStackTrace();
        }
        
        return stdList;
    }

	@Override
	public void insert(Student student) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO student(no, dept, stdId, name) VALUES(?, ?, ?, ?)";
		//id는 자동으로 +1 증가하도록 RETURN_GENERATED_KEYS 메소드 이용
		try(PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			System.out.println("db 연결 성공");
			ps.setInt(1, student.getNo());
			ps.setString(2, student.getDept());
			ps.setString(4, student.getStdID());
			ps.setString(3, student.getName());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public Student findById(String stdID) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Student student) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String stdID) {
		// TODO Auto-generated method stub
		return 0;
	}
}
