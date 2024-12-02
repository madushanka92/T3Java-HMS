package hospital.group.model;

import java.sql.Date;
import java.sql.Time;

public class Appointment {
	
	private int appointmentId;
    private int patientId;
    private int doctorId;
    private int departmentId;
    private Date appointmentDate;
    private Time appointmentTime;
    private String status;
    private String type;
    private String patientFirstName;
    private String patientLastName;
    private String departmentName;
    
    
	public Appointment(int appointmentId, int patientId, int doctorId, int departmentId, Date appointmentDate,
			Time appointmentTime, String status, String type) {
		super();
		this.appointmentId = appointmentId;
		this.patientId = patientId;
		this.doctorId = doctorId;
		this.departmentId = departmentId;
		this.appointmentDate = appointmentDate;
		this.appointmentTime = appointmentTime;
		this.status = status;
		this.type = type;
	}


	public int getAppointmentId() {
		return appointmentId;
	}


	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}


	public int getPatientId() {
		return patientId;
	}


	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}


	public int getDoctorId() {
		return doctorId;
	}


	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}


	public int getDepartmentId() {
		return departmentId;
	}


	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}


	public Date getAppointmentDate() {
		return appointmentDate;
	}


	public void setAppointmentDate(Date appointmentDate) {
		this.appointmentDate = appointmentDate;
	}


	public Time getAppointmentTime() {
		return appointmentTime;
	}


	public void setAppointmentTime(Time appointmentTime) {
		this.appointmentTime = appointmentTime;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
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


	public String getDepartmentName() {
		return departmentName;
	}


	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
    
	
    

}
