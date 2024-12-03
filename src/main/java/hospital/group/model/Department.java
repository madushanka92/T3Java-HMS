package hospital.group.model;

public class Department {
    private int departmentId;
    private String departmentName;
    private int headOfDepartmentId;
    private String headOfDepartmentName; // New field

    public Department(int departmentId, String departmentName, int headOfDepartmentId, String headOfDepartmentName) {
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.headOfDepartmentId = headOfDepartmentId;
        this.headOfDepartmentName = headOfDepartmentName;
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

    public String getHeadOfDepartmentName() {
        return headOfDepartmentName;
    }

    public void setHeadOfDepartmentName(String headOfDepartmentName) {
        this.headOfDepartmentName = headOfDepartmentName;
    }
}
