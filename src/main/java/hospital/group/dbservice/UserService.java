package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Department;
import hospital.group.model.User;
import hospital.group.model.UserRole;

public class UserService {
	public boolean validateUser(String username, String password) {
        boolean isValidUser = false;
        String query = "SELECT * FROM user WHERE userId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
//            preparedStatement.setString(2, password);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
//                    isValidUser = true;  // user exists
                    String dbPassword = resultSet.getString("password");
                    isValidUser = validatePassword(password, dbPassword);

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

	 public String createUser(User newUser) {
		    String sql = "INSERT INTO User (firstName, lastName, email, password, roleId, contactNumber, address, departmentId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		    try (Connection connection = DatabaseConnection.connect();
		         PreparedStatement statement = connection.prepareStatement(sql)) {

		    	String hashedPassword = hashPassword(newUser.getPassword());


		        statement.setString(1, newUser.getFirstName());
		        statement.setString(2, newUser.getLastName());
		        statement.setString(3, newUser.getEmail());
		        statement.setString(4, hashedPassword);  // Ideally, hash the password before storing
		        statement.setInt(5, newUser.getRoleId());
		        statement.setString(6, newUser.getContactNumber());
		        statement.setString(7, newUser.getAddress());
		        statement.setInt(8, newUser.getDepartmentId() == 0 ? null : newUser.getDepartmentId());

		        int rowsAffected = statement.executeUpdate();

		        return rowsAffected > 0 ? "User created successfully!" : "User creation failed.";

		    } catch (SQLException e) {
		        e.printStackTrace();
		        if (e.getErrorCode() == 1062) {
		            return "Email is already registered. Please use a different email.";
		        } else {
		            e.printStackTrace();
		            return "An error occurred while creating the user.";
		        }
		    }
		}

	// Method to hash a password using SHA-256
	    public static String hashPassword(String password) {
	        return DigestUtils.sha256Hex(password);
	    }

	    // Method to validate a password
	    public static boolean validatePassword(String inputPassword, String storedHashedPassword) {
	        String hashedInput = hashPassword(inputPassword);
	        return hashedInput.equals(storedHashedPassword);
	    }
	 public List<User> getAllUsers() {
		    List<User> users = new ArrayList<>();
		    String sql = "SELECT userId, firstName FROM User";

		    try (Connection connection = DatabaseConnection.connect();
		         PreparedStatement statement = connection.prepareStatement(sql);
		         ResultSet resultSet = statement.executeQuery()) {

		        while (resultSet.next()) {
		            users.add(new User(
		                resultSet.getInt("userId"), resultSet.getString("firstName"), sql, sql, sql, 0, sql, sql, null
		            ));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return users;
		}



}
