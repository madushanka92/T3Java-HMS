package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Patient;

public class PatientService {

    // Save Patient
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

    // Get all Patients
    public static List<Patient> getAllPatients() {
        List<Patient> patientList = new ArrayList<>();

        String q = "SELECT patientId, firstName, lastName, dateOfBirth, gender, contactNumber, email, address, emergencyContact, medicalHistory FROM patient";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(q);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientId(rs.getInt("patientId"));
                patient.setFirstName(rs.getString("firstName"));
                patient.setLastName(rs.getString("lastName"));
                patient.setDateOfBirth(rs.getDate("dateOfBirth"));
                patient.setGender(rs.getString("gender"));
                patient.setContactNumber(rs.getString("contactNumber"));
                patient.setEmail(rs.getString("email"));
                patient.setAddress(rs.getString("address"));
                patient.setEmergencyContact(rs.getString("emergencyContact"));
                patient.setMedicalHistory(rs.getString("medicalHistory"));

                patientList.add(patient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return patientList;
    }

    // Get a Patient by ID
    public Patient getPatientById(int patientId) {
        String query = "SELECT * FROM patient WHERE patientId = ?";
        Patient patient = null;

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, patientId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                patient = new Patient();
                patient.setPatientId(rs.getInt("patientId"));
                patient.setFirstName(rs.getString("firstName"));
                patient.setLastName(rs.getString("lastName"));
                patient.setDateOfBirth(rs.getDate("dateOfBirth"));
                patient.setGender(rs.getString("gender"));
                patient.setContactNumber(rs.getString("contactNumber"));
                patient.setEmail(rs.getString("email"));
                patient.setAddress(rs.getString("address"));
                patient.setEmergencyContact(rs.getString("emergencyContact"));
                patient.setMedicalHistory(rs.getString("medicalHistory"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patient;
    }

    // Update Patient details
    public boolean updatePatient(Patient patient) {
        String query = "UPDATE patient SET firstName = ?, lastName = ?, dateOfBirth = ?, gender = ?, contactNumber = ?, email = ?, address = ?, emergencyContact = ?, medicalHistory = ? WHERE patientId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, patient.getFirstName());
            statement.setString(2, patient.getLastName());
            statement.setDate(3, patient.getDateOfBirth());
            statement.setString(4, patient.getGender());
            statement.setString(5, patient.getContactNumber());
            statement.setString(6, patient.getEmail());
            statement.setString(7, patient.getAddress());
            statement.setString(8, patient.getEmergencyContact());
            statement.setString(9, patient.getMedicalHistory());
            statement.setInt(10, patient.getPatientId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // Return true if the patient was updated successfully
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if there was an error
        }
    }

    // Delete Patient by ID
    public boolean deletePatient(int patientId) {
        String query = "DELETE FROM patient WHERE patientId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, patientId);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0; // Return true if the patient was deleted successfully
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if there was an error
        }
    }
}
