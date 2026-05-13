package student;

public class Student {
    private int no;
    private String stdID;
    private String name;
    private String dept;
    
    // 생성자, getter/setter
    
    //기본 생성자
    public Student() {
    }
    
	public Student(int no, String stdID, String name, String dept) {
		super();
		this.no = no;
		this.stdID = stdID;
		this.name = name;
		this.dept = dept;
	}
	
	
    
	public Student(String stdID, String name, String dept) {
		super();
		this.stdID = stdID;
		this.name = name;
		this.dept = dept;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}
	public String getStdID() {
		return stdID;
	}
	public void setStdID(String stdID) {
		this.stdID = stdID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
    
}
