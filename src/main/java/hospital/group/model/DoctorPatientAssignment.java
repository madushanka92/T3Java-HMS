package hospital.group.model;

import java.sql.Timestamp;

public class DoctorPatientAssignment {
	private int assignmentId;
    private int doctorUserId;
    private int patientId;
    private Timestamp assignedDate;
    private String status;
    private boolean primaryDoctor;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String userfirstName;
    private String patientfirstName;

    private String userlastName;
    private String patientlastName;


	public DoctorPatientAssignment(int assignmentId, int doctorUserId, int patientId, Timestamp assignedDate,
			String status, boolean primaryDoctor, String notes, Timestamp createdAt, Timestamp updatedAt) {
		super();
		this.assignmentId = assignmentId;
		this.doctorUserId = doctorUserId;
		this.patientId = patientId;
		this.assignedDate = assignedDate;
		this.status = status;
		this.primaryDoctor = primaryDoctor;
		this.notes = notes;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public DoctorPatientAssignment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getAssignmentId() {
		return assignmentId;
	}
	public void setAssignmentId(int assignmentId) {
		this.assignmentId = assignmentId;
	}
	public int getDoctorUserId() {
		return doctorUserId;
	}
	public void setDoctorUserId(int doctorUserId) {
		this.doctorUserId = doctorUserId;
	}
	public int getPatientId() {
		return patientId;
	}
	public void setPatientId(int patientId) {
		this.patientId = patientId;
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
	public boolean isPrimaryDoctor() {
		return primaryDoctor;
	}
	public void setPrimaryDoctor(boolean primaryDoctor) {
		this.primaryDoctor = primaryDoctor;
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

	public String getUserfirstName() {
		return userfirstName;
	}
	public void setUserfirstName(String userfirstName) {
		this.userfirstName = userfirstName;
	}
	public String getPatientfirstName() {
		return patientfirstName;
	}
	public void setPatientfirstName(String patientfirstName) {
		this.patientfirstName = patientfirstName;
	}
	public String getUserlastName() {
		return userlastName;
	}
	public void setUserlastName(String userlastName) {
		this.userlastName = userlastName;
	}
	public String getPatientlastName() {
		return patientlastName;
	}
	public void setPatientlastName(String patientlastName) {
		this.patientlastName = patientlastName;
	}
}
