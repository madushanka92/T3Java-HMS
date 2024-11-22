package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class AssignmentService {

    // Method to create Doctor-Patient assignment
    public void createDoctorPatientAssignment(Connection connection, int doctorUserId, String patientId, String notes, String primaryDoctor, Timestamp assignedDate, String status) throws SQLException {
        String sql = "INSERT INTO DoctorPatientAssignment (doctorUserId, patientId, notes, primaryDoctor, assignedDate, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, doctorUserId);
            statement.setInt(2, Integer.parseInt(patientId));
            statement.setString(3, notes);
            statement.setBoolean(4, Boolean.parseBoolean(primaryDoctor));
            statement.setTimestamp(5, assignedDate);
            statement.setString(6, status);
            statement.executeUpdate();
        }
    }

    // Method to create Nurse-Doctor assignment
    public void createNurseDoctorAssignment(Connection connection, int nurseUserId, String doctorUserId, String notes, String shiftType, Timestamp assignedDate, String status) throws SQLException {
        String sql = "INSERT INTO NurseDoctorAssignment (nurseUserId, doctorUserId, notes, shiftType, assignedDate, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, nurseUserId);
            statement.setInt(2, Integer.parseInt(doctorUserId));
            statement.setString(3, notes);
            statement.setString(4, shiftType);
            statement.setTimestamp(5, assignedDate);
            statement.setString(6, status);
            statement.executeUpdate();
        }
    }

    // Method to create Technician-Patient assignment
    public void createTechnicianPatientAssignment(Connection connection, int technicianUserId, String patientId, String notes, String serviceType, Timestamp assignedDate, String status, String scheduledDate) throws SQLException {
        String sql = "INSERT INTO TechnicianPatientAssignment (technicianUserId, patientId, notes, serviceType, assignedDate, status, scheduledDateTime) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, technicianUserId);
            statement.setInt(2, Integer.parseInt(patientId));
            statement.setString(3, notes);
            statement.setString(4, serviceType);
            statement.setTimestamp(5, assignedDate);
            statement.setString(6, status);
            statement.setString(7, scheduledDate);
            statement.executeUpdate();
        }
    }

    // Method to create Technician-Department assignment
    public void createTechnicianDepartmentAssignment(Connection connection, int technicianUserId, String departmentId, String notes, String workShift, Timestamp assignedDate, String status, String startDate) throws SQLException {
        String sql = "INSERT INTO TechnicianDepartmentAssignment (technicianUserId, departmentId, notes, workShift, assignedDate, status, startDate) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, technicianUserId);
            statement.setInt(2, Integer.parseInt(departmentId));
            statement.setString(3, notes);
            statement.setString(4, workShift);
            statement.setTimestamp(5, assignedDate);
            statement.setString(6, status);
            statement.setDate(7, java.sql.Date.valueOf(startDate));
            statement.executeUpdate();
        }
    }
}
