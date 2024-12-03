package hospital.group.model;

import java.sql.Date;

public class Payment {
    private int paymentId;
    private int patientId;
    private String serviceName;
    private double amount;
    private Date paymentDate;
    private String status;

    public Payment() {
        // Default constructor
    }

    public Payment(int paymentId, int patientId, String serviceName, double amount, Date paymentDate, String status) {
        this.paymentId = paymentId;
        this.patientId = patientId;
        this.serviceName = serviceName;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.status = status;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
