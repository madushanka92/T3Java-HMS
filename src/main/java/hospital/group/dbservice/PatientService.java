package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Patient;

public class PatientService {

	public boolean savePatient(Patient patient) {
	    String sql = "INSERT INTO Patient (firstName, lastName, dateOfBirth, gender, contactNumber, email, address, emergencyContact, medicalHistory) "
	            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        statement.setString(1, patient.getFirstName());
	        statement.setString(2, patient.getLastName());
	        statement.setDate(3, patient.getDateOfBirth());
	        statement.setString(4, patient.getGender());
	        statement.setString(5, patient.getContactNumber());
	        statement.setString(6, patient.getEmail());
	        statement.setString(7, patient.getAddress());
	        statement.setString(8, patient.getEmergencyContact());
	        statement.setString(9, patient.getMedicalHistory());

	        int rowsAffected = statement.executeUpdate();

	        return rowsAffected > 0; // Return true if patient saved successfully
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false; // Return false if there was an error
	    }
	}
}
