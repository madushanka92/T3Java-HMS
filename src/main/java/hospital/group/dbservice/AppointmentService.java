package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Appointment;

public class AppointmentService {

	public Appointment createAppointment(int patientId, int doctorId, int departmentId, Date appointmentDate,
            Time appointmentTime, String status, String type) {
			String query = "INSERT INTO Appointment (patientId, doctorId, departmentId, appointmentDate, appointmentTime, status, type) VALUES (?, ?, ?, ?, ?, ?, ?)";
			Appointment appointment = null;

			try (Connection connection = DatabaseConnection.connect();
			PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

				statement.setInt(1, patientId);
				statement.setInt(2, doctorId);
				statement.setInt(3, departmentId);
				statement.setDate(4, appointmentDate);
				statement.setTime(5, appointmentTime);
				statement.setString(6, status);
				statement.setString(7, type);

				int rowsAffected = statement.executeUpdate();
				if (rowsAffected > 0) {
					// Get the generated appointmentId
					var rs = statement.getGeneratedKeys();
					if (rs.next()) {
						int appointmentId = rs.getInt(1);
						appointment = new Appointment(appointmentId, patientId, doctorId, departmentId, appointmentDate, appointmentTime, status, type);
					}
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

			return appointment;
	}

	public List<Appointment> getAppointmentsForDoctor(Integer doctorId) {
	    List<Appointment> appointments = new ArrayList<>();
	    String query = "SELECT a.appointmentId, a.patientId, a.doctorId, a.departmentId, a.appointmentDate, " +
	                   "a.appointmentTime, a.status, a.type, p.firstName AS patientFirstName, p.lastName AS patientLastName, " +
	                   "d.departmentName " +
	                   "FROM Appointment a " +
	                   "JOIN Patient p ON a.patientId = p.patientId " +
	                   "JOIN Department d ON a.departmentId = d.departmentId ";

	    System.out.println("doctorId " + doctorId);

	    // Add the WHERE clause only if doctorId is not null
	    if (doctorId != 0) {
	        query += "WHERE a.doctorId = ?";
	    }

	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(query)) {

	        // Set the parameter if doctorId is not null
	        if (doctorId != 0) {
	            statement.setInt(1, doctorId);
	        }

	        ResultSet rs = statement.executeQuery();

	        while (rs.next()) {
	            // Create an Appointment object with the results from the query
	            Appointment appointment = new Appointment(
	                rs.getInt("appointmentId"),
	                rs.getInt("patientId"),
	                rs.getInt("doctorId"),
	                rs.getInt("departmentId"),
	                rs.getDate("appointmentDate"),
	                rs.getTime("appointmentTime"),
	                rs.getString("status"),
	                rs.getString("type")
	            );

	            // Add extra patient and department details to the appointment
	            appointment.setPatientFirstName(rs.getString("patientFirstName"));
	            appointment.setPatientLastName(rs.getString("patientLastName"));
	            appointment.setDepartmentName(rs.getString("departmentName"));

	            appointments.add(appointment);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return appointments;
	}


    public boolean markAppointmentAsCompleted(int appointmentId) {
        String query = "UPDATE Appointment SET status = 'Completed' WHERE appointmentId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, appointmentId);
            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0; // Returns true if update is successful
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // Returns false if the update fails
    }
}
