package hospital.group.model;

import java.sql.Timestamp;

public class NurseDoctorAssignment {
	private int assignmentId;
    private int nurseUserId;
    private int doctorUserId;
    private Timestamp assignedDate;
    private String status;
    private String shiftType;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String nurseFirstName;
    private String nurseLastName;
    private String doctorFirstName;
    private String doctorLastName;



	public NurseDoctorAssignment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getAssignmentId() {
		return assignmentId;
	}
	public void setAssignmentId(int assignmentId) {
		this.assignmentId = assignmentId;
	}
	public int getNurseUserId() {
		return nurseUserId;
	}
	public void setNurseUserId(int nurseUserId) {
		this.nurseUserId = nurseUserId;
	}
	public int getDoctorUserId() {
		return doctorUserId;
	}
	public void setDoctorUserId(int doctorUserId) {
		this.doctorUserId = doctorUserId;
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
	public String getShiftType() {
		return shiftType;
	}
	public void setShiftType(String shiftType) {
		this.shiftType = shiftType;
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
	public String getNurseFirstName() {
		return nurseFirstName;
	}
	public void setNurseFirstName(String nurseFirstName) {
		this.nurseFirstName = nurseFirstName;
	}
	public String getNurseLastName() {
		return nurseLastName;
	}
	public void setNurseLastName(String nurseLastName) {
		this.nurseLastName = nurseLastName;
	}
	public String getDoctorFirstName() {
		return doctorFirstName;
	}
	public void setDoctorFirstName(String doctorFirstName) {
		this.doctorFirstName = doctorFirstName;
	}
	public String getDoctorLastName() {
		return doctorLastName;
	}
	public void setDoctorLastName(String doctorLastName) {
		this.doctorLastName = doctorLastName;
	}




}
