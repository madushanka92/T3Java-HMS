package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Room;

public class RoomService {

	public static Room getRoomById(String roomId) {
        String query = "SELECT * FROM room WHERE roomId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, roomId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Create a room object from the result set
                return new Room(
                    resultSet.getString("roomId"),
                    resultSet.getString("roomNumber"),
                    resultSet.getString("roomType"),
                    resultSet.getString("availabilityStatus"),
                    resultSet.getString("assignedPatientId"),
                    resultSet.getInt("floorNumber"),
                    resultSet.getString("departmentId"),
                    resultSet.getString("lastCleanedAt"),
                    resultSet.getDouble("dailyRate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if room is not found
    }


	public boolean updateRoom(String roomId, String roomNumber, String roomType, String availabilityStatus,
            String assignedPatientId, int floorNumber, String departmentId,
            String lastCleanedAt, double dailyRate) {
			String query = "UPDATE room SET roomNumber = ?, roomType = ?, availabilityStatus = ?, " +
			     "assignedPatientId = ?, floorNumber = ?, departmentId = ?, lastCleanedAt = ?, dailyRate = ? " +
			     "WHERE roomId = ?";

			try (Connection connection = DatabaseConnection.connect();
			PreparedStatement statement = connection.prepareStatement(query)) {

				// Set values in prepared statement
				statement.setString(1, roomNumber);
				statement.setString(2, roomType);
				statement.setString(3, availabilityStatus);

				// If assignedPatientId is empty, set it as null
				if (assignedPatientId == null || assignedPatientId.trim().isEmpty()) {
					statement.setNull(4, java.sql.Types.VARCHAR);  // Set NULL for assignedPatientId
				} else {
				statement.setString(4, assignedPatientId);
				}

				statement.setInt(5, floorNumber);
				statement.setString(6, departmentId);
				statement.setString(7, lastCleanedAt);
				statement.setDouble(8, dailyRate);
				statement.setString(9, roomId);

				// Execute the update
				int rowsUpdated = statement.executeUpdate();
				System.out.println("Rows updated: " + rowsUpdated);  // Debugging: Check how many rows were updated

				// Return true if at least one row was updated
				return rowsUpdated > 0;
			} catch (SQLException e) {
				e.printStackTrace();
				System.err.println("Error updating room: " + e.getMessage());
			return false;
		}
	}

	// Delete room from the database
    public boolean deleteRoom(String roomId) {
        String query = "DELETE FROM room WHERE roomId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set roomId in prepared statement
            statement.setString(1, roomId);

            int rowsDeleted = statement.executeUpdate();
            System.out.println("Rows deleted: " + rowsDeleted);  // Debugging: Check how many rows were deleted

            // Return true if at least one row was deleted
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting room: " + e.getMessage());
            return false;
        }
    }

    // Method to save a new room to the database
    public boolean saveRoom(String roomNumber, String roomType, String availabilityStatus,
                            String assignedPatientId, int floorNumber, String departmentId,
                            String lastCleanedAt, double dailyRate) {
        String query = "INSERT INTO room (roomNumber, roomType, availabilityStatus, assignedPatientId, " +
                       "floorNumber, departmentId, lastCleanedAt, dailyRate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set values in prepared statement
            statement.setString(1, roomNumber);
            statement.setString(2, roomType);
            statement.setString(3, availabilityStatus);

            // If assignedPatientId is empty, set it as null
            if (assignedPatientId == null || assignedPatientId.trim().isEmpty()) {
                statement.setNull(4, java.sql.Types.VARCHAR);  // Set NULL for assignedPatientId
            } else {
                statement.setString(4, assignedPatientId);
            }

            statement.setInt(5, floorNumber);
            statement.setString(6, departmentId);
            statement.setString(7, lastCleanedAt);
            statement.setDouble(8, dailyRate);

            // Execute the insert
            int rowsInserted = statement.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);  // Debugging: Check how many rows were inserted

            // Return true if at least one row was inserted
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error saving room: " + e.getMessage());
            return false;
        }
    }
}
