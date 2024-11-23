package hospital.group.model;

import java.sql.Date;
import java.sql.Timestamp;

public class TechnicianDepartmentAssignment {
	private int assignmentId;
    private int technicianUserId;
    private int departmentId;
    private Timestamp assignedDate;
    private String status;
    private String workShift;
    private Date startDate;
    private Date endDate;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String technicianFirstName;
    private String technicianLastName;
    private String departmentName;
	public int getAssignmentId() {
		return assignmentId;
	}
	public void setAssignmentId(int assignmentId) {
		this.assignmentId = assignmentId;
	}
	public int getTechnicianUserId() {
		return technicianUserId;
	}
	public void setTechnicianUserId(int technicianUserId) {
		this.technicianUserId = technicianUserId;
	}
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public Timestamp getAssignedDate() {
		return assignedDate;
	}
	public void setAssignedDate(Timestamp assignedDate) {
		this.assignedDate = assignedDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getWorkShift() {
		return workShift;
	}
	public void setWorkShift(String workShift) {
		this.workShift = workShift;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getTechnicianFirstName() {
		return technicianFirstName;
	}
	public void setTechnicianFirstName(String technicianFirstName) {
		this.technicianFirstName = technicianFirstName;
	}
	public String getTechnicianLastName() {
		return technicianLastName;
	}
	public void setTechnicianLastName(String technicianLastName) {
		this.technicianLastName = technicianLastName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}


}
