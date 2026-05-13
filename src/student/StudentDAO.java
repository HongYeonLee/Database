package student;

import java.util.List;

public interface StudentDAO {
    void insert(Student student);
    List<Student> findAll();
    Student findById(String stdID);
    int update(Student student);
    int delete(String stdID);
}
