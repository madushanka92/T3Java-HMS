package hospital.group.model;

public class Department {
	private int departmentId;
    private String departmentName;
    private int headOfDepartmentId;

	public Department(int departmentId, String departmentName, int headOfDepartmentId) {
		super();
		this.departmentId = departmentId;
		this.departmentName = departmentName;
		this.headOfDepartmentId = headOfDepartmentId;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public int getHeadOfDepartmentId() {
		return headOfDepartmentId;
	}

	public void setHeadOfDepartmentId(int headOfDepartmentId) {
		this.headOfDepartmentId = headOfDepartmentId;
	}




}
