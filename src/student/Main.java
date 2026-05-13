package student;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class Main {

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
        Connection conn = DatabaseConnector.getConnection();
        StudentDAO dao = new StudentDAOImpl(conn);
        StudentService service = new StudentService(dao);
//        StudentView view = new StudentView();
//        StudentController controller = new StudentController(view, service);
//        controller.run();
        
        //조회하기
        List<Student> foundStudent = service.getAllStudent();
        for (Student std : foundStudent) {
        	System.out.println(std.getName());
        }
        
        //저장하기
        service.save(new Student(23, "컴퓨터공학", "2317049", "이홍연"));
	}

}
