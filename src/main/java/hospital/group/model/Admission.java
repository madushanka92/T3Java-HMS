package hospital.group.model;

import java.sql.Timestamp;

public class Admission {
	private int admissionId;
    private int patientId;
    private int roomId;
    private int departmentId;
    private Timestamp admissionDate;
    private Timestamp dischargeDate;
    private String admissionStatus;
    private String notes;
    private String patientName; // Patient full name
    private String roomNumber; // Room number or "Waiting"
    private String departmentName; // Department name

	public Admission(int admissionId, int patientId, int roomId, int departmentId, Timestamp admissionDate,
			Timestamp dischargeDate, String admissionStatus, String notes) {
		super();
		this.admissionId = admissionId;
		this.patientId = patientId;
		this.roomId = roomId;
		this.departmentId = departmentId;
		this.admissionDate = admissionDate;
		this.dischargeDate = dischargeDate;
		this.admissionStatus = admissionStatus;
		this.notes = notes;
	}





	public Admission(int admissionId, String patientName, String roomNumber, String departmentName, String admissionStatus,Timestamp admissionDate, Timestamp dischargeDate,
			String notes) {
		super();
		this.admissionId = admissionId;
		this.admissionDate = admissionDate;
		this.dischargeDate = dischargeDate;
		this.admissionStatus = admissionStatus;
		this.notes = notes;
		this.patientName = patientName;
		this.roomNumber = roomNumber;
		this.departmentName = departmentName;
	}



	public String getPatientName() {
		return patientName;
	}



	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}



	public String getRoomNumber() {
		return roomNumber;
	}



	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}



	public String getDepartmentName() {
		return departmentName;
	}



	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}



	public Admission() {
		// TODO Auto-generated constructor stub
	}











	public int getAdmissionId() {
		return admissionId;
	}

	public void setAdmissionId(int admissionId) {
		this.admissionId = admissionId;
	}

	public int getPatientId() {
		return patientId;
	}

	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public Timestamp getAdmissionDate() {
		return admissionDate;
	}

	public void setAdmissionDate(Timestamp admissionDate) {
		this.admissionDate = admissionDate;
	}

	public Timestamp getDischargeDate() {
		return dischargeDate;
	}

	public void setDischargeDate(Timestamp dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public String getAdmissionStatus() {
		return admissionStatus;
	}

	public void setAdmissionStatus(String admissionStatus) {
		this.admissionStatus = admissionStatus;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}



}
