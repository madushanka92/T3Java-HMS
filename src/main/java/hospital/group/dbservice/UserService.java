package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import hospital.group.db.DatabaseConnection;

public class UserService {
	public boolean validateUser(String username, String password) {
        boolean isValidUser = false;
        String query = "SELECT * FROM user WHERE userId = ? AND password = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    isValidUser = true;  // user exists
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isValidUser;
    }
}
