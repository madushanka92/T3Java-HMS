package hospital.group.model;

import java.sql.Timestamp;

public class TechnicianPatientAssignment {

	private int assignmentId;
    private int technicianUserId;
    private int patientId;
    private Timestamp assignedDate;
    private String serviceType;
    private String status;
    private Timestamp scheduledDateTime;
    private Timestamp completedDateTime;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String technicianFirstName;
    private String technicianLastName;
    private String patientFirstName;
    private String patientLastName;

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
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Timestamp getScheduledDateTime() {
		return scheduledDateTime;
	}
	public void setScheduledDateTime(Timestamp scheduledDateTime) {
		this.scheduledDateTime = scheduledDateTime;
	}
	public Timestamp getCompletedDateTime() {
		return completedDateTime;
	}
	public void setCompletedDateTime(Timestamp completedDateTime) {
		this.completedDateTime = completedDateTime;
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
	public String getPatientFirstName() {
		return patientFirstName;
	}
	public void setPatientFirstName(String patientFirstName) {
		this.patientFirstName = patientFirstName;
	}
	public String getPatientLastName() {
		return patientLastName;
	}
	public void setPatientLastName(String patientLastName) {
		this.patientLastName = patientLastName;
	}
}
