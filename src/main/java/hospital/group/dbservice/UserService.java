package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Department;
import hospital.group.model.User;
import hospital.group.model.UserRole;

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

	public List<UserRole> getAllRoles() {
        List<UserRole> roles = new ArrayList<>();
        String sql = "SELECT roleId, roleName FROM UserRole";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                roles.add(new UserRole(
                    resultSet.getInt("roleId"),
                    resultSet.getString("roleName")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

	 public List<Department> getAllDepartments() {
	        List<Department> departments = new ArrayList<>();
	        String sql = "SELECT departmentId, departmentName FROM Department";

	        try (Connection connection = DatabaseConnection.connect();
	             PreparedStatement statement = connection.prepareStatement(sql);
	             ResultSet resultSet = statement.executeQuery()) {

	            while (resultSet.next()) {
	                departments.add(new Department(
	                    resultSet.getInt("departmentId"),
	                    resultSet.getString("departmentName"), 0
	                ));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return departments;
	    }

	 public boolean createUser(User newUser) {
		    String sql = "INSERT INTO User (firstName, lastName, email, password, roleId, contactNumber, address, departmentId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		    try (Connection connection = DatabaseConnection.connect();
		         PreparedStatement statement = connection.prepareStatement(sql)) {

		        statement.setString(1, newUser.getFirstName());
		        statement.setString(2, newUser.getLastName());
		        statement.setString(3, newUser.getEmail());
		        statement.setString(4, newUser.getPassword());  // Ideally, hash the password before storing
		        statement.setInt(5, newUser.getRoleId());
		        statement.setString(6, newUser.getContactNumber());
		        statement.setString(7, newUser.getAddress());
		        statement.setInt(8, newUser.getDepartmentId() == 0 ? null : newUser.getDepartmentId());

		        int rowsAffected = statement.executeUpdate();

		        return rowsAffected > 0;
		    } catch (SQLException e) {
		        e.printStackTrace();
		        return false; // Return
		    }
		}
}
