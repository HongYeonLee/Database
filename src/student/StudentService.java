package student;

import java.util.List;

public class StudentService {
	private final StudentDAO dao;
	
	public StudentService(StudentDAO dao) {
		this.dao = dao;
	}
	
	public List<Student> getAllStudent(){
		return dao.findAll();
	}
	
	//insert까지만 완료
	public void save(Student s) {
		dao.insert(s);
	}
	
}
