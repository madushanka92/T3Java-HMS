package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Admission;

public class AdmissionService {

	public List<Admission> getAllAdmissions() {
	    String sql = """
	        SELECT
	            a.admissionId,
	            p.firstName AS patientFirstName,
	            p.lastName AS patientLastName,
	            r.roomNumber,
	            r.roomType,
	            d.departmentName,
	            a.admissionStatus,
	            a.admissionDate,
	            a.dischargeDate,
	            a.notes
	        FROM
	            Admissions a
	        JOIN
	            Patient p ON a.patientId = p.patientId
	        LEFT JOIN
	            Room r ON a.roomId = r.roomId
	        JOIN
	            Department d ON a.departmentId = d.departmentId
	        ORDER BY
	            a.admissionId DESC
	    """;

	    List<Admission> admissions = new ArrayList<>();
	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql);
	         ResultSet resultSet = statement.executeQuery()) {

	        while (resultSet.next()) {
	            Admission admission = new Admission(
	                resultSet.getInt("admissionId"),
	                resultSet.getString("patientFirstName") + " " + resultSet.getString("patientLastName"),
	                resultSet.getString("roomNumber"),
	                resultSet.getString("departmentName"),
	                resultSet.getString("admissionStatus"),
	                resultSet.getTimestamp("admissionDate"),
	                resultSet.getTimestamp("dischargeDate"),
	                resultSet.getString("notes")
	            );
	            admissions.add(admission);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return admissions;
	}


	public boolean createAdmission(Admission admission) {
        String sql = "INSERT INTO Admissions (patientId, roomId, departmentId, admissionDate, dischargeDate, admissionStatus, notes) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

        	Timestamp admissionDate = admission.getAdmissionDate();

            statement.setInt(1, admission.getPatientId());
            if (admission.getRoomId() == 0) {
                statement.setNull(2, Types.INTEGER);
            } else {
                statement.setInt(2, admission.getRoomId());
            }
            statement.setInt(3, admission.getDepartmentId());

            if (admissionDate != null) {
                statement.setTimestamp(4, admissionDate);
            } else {
                statement.setNull(4, Types.TIMESTAMP);
            }

            statement.setTimestamp(5, admission.getDischargeDate());
            statement.setString(6, admission.getAdmissionStatus());
            statement.setString(7, admission.getNotes());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

	public Admission getAdmissionById(int admissionId) {
        String sql = "SELECT * FROM Admissions WHERE admissionId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, admissionId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Admission(
                    resultSet.getInt("admissionId"),
                    resultSet.getInt("patientId"),
                    resultSet.getInt("roomId"),
                    resultSet.getInt("departmentId"),
                    resultSet.getTimestamp("admissionDate"),
                    resultSet.getTimestamp("dischargeDate"),
                    resultSet.getString("admissionStatus"),
                    resultSet.getString("notes")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

	public boolean updateAdmission(Admission admission) {
        String sql = "UPDATE Admissions SET patientId = ?, roomId = ?, departmentId = ?, admissionDate = ?, dischargeDate = ?, admissionStatus = ?, notes = ? WHERE admissionId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, admission.getPatientId());
            if (admission.getRoomId() == 0) {
                statement.setNull(2, Types.INTEGER);
            } else {
                statement.setInt(2, admission.getRoomId());
            }
            statement.setInt(3, admission.getDepartmentId());
            statement.setTimestamp(4, admission.getAdmissionDate());
            statement.setTimestamp(5, admission.getDischargeDate());
            statement.setString(6, admission.getAdmissionStatus());
            statement.setString(7, admission.getNotes());
            statement.setInt(8, admission.getAdmissionId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

	public boolean deleteAdmission(int admissionId) {
	    String sql = "DELETE FROM Admissions WHERE admissionId = ?";
	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setInt(1, admissionId);
	        return statement.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
}
