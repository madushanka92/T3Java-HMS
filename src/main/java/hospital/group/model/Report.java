package hospital.group.model;

import java.time.LocalDate;

public class Report {
    private String reportId;
    private int patientId;
    private String diagnosis;
    private String treatment;
    private LocalDate reportDate;

    // Constructor
    public Report(String reportId, int patientId, String diagnosis, String treatment, LocalDate reportDate) {
        this.reportId = reportId;
        this.patientId = patientId;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.reportDate = reportDate;
    }


	// Getters and Setters
    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public LocalDate getReportDate() {
        return reportDate;
    }

    public void setReportDate(LocalDate reportDate) {
        this.reportDate = reportDate;
    }

	

}
