package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.DoctorPatientAssignment;
import hospital.group.model.NurseDoctorAssignment;
import hospital.group.model.TechnicianDepartmentAssignment;
import hospital.group.model.TechnicianPatientAssignment;

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

    public List<DoctorPatientAssignment> getAllDoctorPatientAssignments() {

    	String query = "SELECT dpa.assignmentId, dpa.doctorUserId, u.firstName as userfirstName, u.lastName as userlastName, dpa.patientId, p.firstName as patientfirstName, p.lastName as patientlastName, " +
                "dpa.assignedDate, dpa.status, dpa.primaryDoctor, dpa.notes " +
                "FROM DoctorPatientAssignment dpa " +
                "JOIN User u ON dpa.doctorUserId = u.userId " +
                "JOIN Patient p ON dpa.patientId = p.patientId " +
                "ORDER BY dpa.assignedDate DESC";

        List<DoctorPatientAssignment> assignments = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                DoctorPatientAssignment assignment = new DoctorPatientAssignment();
                assignment.setAssignmentId(rs.getInt("assignmentId"));
                assignment.setDoctorUserId(rs.getInt("doctorUserId"));
                assignment.setPatientId(rs.getInt("patientId"));
                assignment.setAssignedDate(rs.getTimestamp("assignedDate"));
                assignment.setStatus(rs.getString("status"));
                assignment.setPrimaryDoctor(rs.getBoolean("primaryDoctor"));
                assignment.setNotes(rs.getString("notes"));


                assignment.setUserfirstName(rs.getString("userfirstName"));
                assignment.setUserlastName(rs.getString("userlastName"));
                assignment.setPatientfirstName(rs.getString("patientfirstName"));
                assignment.setPatientlastName(rs.getString("patientlastName"));


                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Log the error (use a logging framework in production)
        }

        System.out.println("Fetched Assignments: " + assignments.size()); // Check if assignments are fetched


        return assignments; // Return an empty list if no records are found or an error occurs
    }

    public List<NurseDoctorAssignment> getAllNurseDoctorAssignments() {
        String query = "SELECT nda.assignmentId, nda.nurseUserId, u1.firstName as nurseFirstName, u1.lastName as nurseLastName, " +
                       "nda.doctorUserId, u2.firstName as doctorFirstName, u2.lastName as doctorLastName, " +
                       "nda.assignedDate, nda.status, nda.shiftType, nda.notes " +
                       "FROM NurseDoctorAssignment nda " +
                       "JOIN User u1 ON nda.nurseUserId = u1.userId " +
                       "JOIN User u2 ON nda.doctorUserId = u2.userId " +
                       "ORDER BY nda.assignedDate DESC";

        List<NurseDoctorAssignment> assignments = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                NurseDoctorAssignment assignment = new NurseDoctorAssignment();
                assignment.setAssignmentId(rs.getInt("assignmentId"));
                assignment.setNurseUserId(rs.getInt("nurseUserId"));
                assignment.setDoctorUserId(rs.getInt("doctorUserId"));
                assignment.setAssignedDate(rs.getTimestamp("assignedDate"));
                assignment.setStatus(rs.getString("status"));
                assignment.setShiftType(rs.getString("shiftType"));
                assignment.setNotes(rs.getString("notes"));

                assignment.setNurseFirstName(rs.getString("nurseFirstName"));
                assignment.setNurseLastName(rs.getString("nurseLastName"));
                assignment.setDoctorFirstName(rs.getString("doctorFirstName"));
                assignment.setDoctorLastName(rs.getString("doctorLastName"));

                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Log the error (use a logging framework in production)
        }

        return assignments;
    }

    public List<TechnicianPatientAssignment> getAllTechnicianPatientAssignments() {
        String query = "SELECT tpa.assignmentId, tpa.technicianUserId, u1.firstName AS technicianFirstName, u1.lastName AS technicianLastName, " +
                       "tpa.patientId, p.firstName AS patientFirstName, p.lastName AS patientLastName, " +
                       "tpa.assignedDate, tpa.serviceType, tpa.status, tpa.scheduledDateTime, tpa.completedDateTime, tpa.notes " +
                       "FROM TechnicianPatientAssignment tpa " +
                       "JOIN User u1 ON tpa.technicianUserId = u1.userId " +
                       "JOIN Patient p ON tpa.patientId = p.patientId " +
                       "ORDER BY tpa.scheduledDateTime DESC";

        List<TechnicianPatientAssignment> assignments = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                TechnicianPatientAssignment assignment = new TechnicianPatientAssignment();
                assignment.setAssignmentId(rs.getInt("assignmentId"));
                assignment.setTechnicianUserId(rs.getInt("technicianUserId"));
                assignment.setPatientId(rs.getInt("patientId"));
                assignment.setAssignedDate(rs.getTimestamp("assignedDate"));
                assignment.setServiceType(rs.getString("serviceType"));
                assignment.setStatus(rs.getString("status"));
                assignment.setScheduledDateTime(rs.getTimestamp("scheduledDateTime"));
                assignment.setCompletedDateTime(rs.getTimestamp("completedDateTime"));
                assignment.setNotes(rs.getString("notes"));

                assignment.setTechnicianFirstName(rs.getString("technicianFirstName"));
                assignment.setTechnicianLastName(rs.getString("technicianLastName"));
                assignment.setPatientFirstName(rs.getString("patientFirstName"));
                assignment.setPatientLastName(rs.getString("patientLastName"));

                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Log the error (use a logging framework in production)
        }

        return assignments;
    }

    public List<TechnicianDepartmentAssignment> getAllTechnicianDepartmentAssignments() {
        String query = "SELECT tda.assignmentId, tda.technicianUserId, u1.firstName AS technicianFirstName, u1.lastName AS technicianLastName, " +
                       "tda.departmentId, d.departmentName AS departmentName, tda.assignedDate, tda.status, tda.workShift, " +
                       "tda.startDate, tda.endDate, tda.notes " +
                       "FROM TechnicianDepartmentAssignment tda " +
                       "JOIN User u1 ON tda.technicianUserId = u1.userId " +
                       "JOIN Department d ON tda.departmentId = d.departmentId " +
                       "ORDER BY tda.startDate DESC";

        List<TechnicianDepartmentAssignment> assignments = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                TechnicianDepartmentAssignment assignment = new TechnicianDepartmentAssignment();
                assignment.setAssignmentId(rs.getInt("assignmentId"));
                assignment.setTechnicianUserId(rs.getInt("technicianUserId"));
                assignment.setDepartmentId(rs.getInt("departmentId"));
                assignment.setAssignedDate(rs.getTimestamp("assignedDate"));
                assignment.setStatus(rs.getString("status"));
                assignment.setWorkShift(rs.getString("workShift"));
                assignment.setStartDate(rs.getDate("startDate"));
                assignment.setEndDate(rs.getDate("endDate"));
                assignment.setNotes(rs.getString("notes"));

                assignment.setTechnicianFirstName(rs.getString("technicianFirstName"));
                assignment.setTechnicianLastName(rs.getString("technicianLastName"));
                assignment.setDepartmentName(rs.getString("departmentName"));

                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assignments;
    }
}
