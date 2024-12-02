package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Department;
import hospital.group.model.User;
import hospital.group.model.UserRole;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class UserService {
	public boolean validateUser(HttpServletRequest request,String username, String password) {
        boolean isValidUser = false;
        String query = "SELECT u.userId, u.password, u.firstName, u.lastName, u.email, u.contactNumber, " +
                "u.address, ur.roleId, ur.roleName, d.departmentId, d.departmentName, " +
                "d.headOfDepartmentId " +
                "FROM User u " +
                "LEFT JOIN UserRole ur ON u.roleId = ur.roleId " +
                "LEFT JOIN Department d ON u.departmentId = d.departmentId " +
                "WHERE u.userId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String dbPassword = resultSet.getString("password");
                    isValidUser = validatePassword(password, dbPassword);

                    User user = new User();
                    user.setUserId(resultSet.getInt("userId"));
                    user.setFirstName(resultSet.getString("firstName"));
                    user.setLastName(resultSet.getString("lastName"));
                    user.setEmail(resultSet.getString("email"));
                    user.setContactNumber(resultSet.getString("contactNumber"));
                    user.setAddress(resultSet.getString("address"));
                    user.setRoleId(resultSet.getInt("roleId"));
                    user.setRoleName(resultSet.getString("roleName"));
                    user.setDepartmentId(resultSet.getInt("departmentId"));
                    user.setDepartmentName(resultSet.getString("departmentName"));

                    HttpSession session = request.getSession();
                    session.setAttribute("loggedInUser", user);
        	    	session.setAttribute("userId", user.getUserId());
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isValidUser;
    }

	public User getUserFromSession(HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");

		return user;
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
        return getAllUsers(null);  // Default role is "All", which fetches all users
    }

    public List<User> getAllUsers(String roleName) {
	    List<User> users = new ArrayList<>();
	    String sql = "SELECT u.userId, u.firstName, u.lastName, u.email, ur.roleName, d.departmentName " +
                "FROM User u " +
                "LEFT JOIN UserRole ur ON u.roleId = ur.roleId " +
                "LEFT JOIN Department d ON u.departmentId = d.departmentId";

	    if (roleName != null && !roleName.isEmpty()) {
	        sql += " WHERE ur.roleName = ?";
	    }


	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql);
	        ) {

	    	if (roleName != null && !roleName.isEmpty()) {
	            statement.setString(1, roleName);
	        }

	    	try (ResultSet resultSet = statement.executeQuery()) {
		        while (resultSet.next()) {
		            users.add(new User(
		                resultSet.getInt("userId"), resultSet.getString("firstName"), resultSet.getString("lastName"),resultSet.getString("email"), sql,  0, sql, sql, null
		            ,resultSet.getString("roleName"), resultSet.getString("departmentName") ));
		        }
	    	}
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return users;
	}

    public User getUserById(int userId) {
        User user = null;
        String query = "SELECT u.userId, u.firstName, u.lastName, u.email, u.password, u.contactNumber, " +
                "u.address, ur.roleId, ur.roleName, d.departmentId, d.departmentName " +
                "FROM User u " +
                "LEFT JOIN UserRole ur ON u.roleId = ur.roleId " +
                "LEFT JOIN Department d ON u.departmentId = d.departmentId " +
                "WHERE u.userId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, userId);  // Set the userId parameter

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User();
                    user.setUserId(resultSet.getInt("userId"));
                    user.setFirstName(resultSet.getString("firstName"));
                    user.setLastName(resultSet.getString("lastName"));
                    user.setEmail(resultSet.getString("email"));
                    user.setContactNumber(resultSet.getString("contactNumber"));
                    user.setAddress(resultSet.getString("address"));
                    user.setRoleId(resultSet.getInt("roleId"));
                    user.setRoleName(resultSet.getString("roleName"));
                    user.setDepartmentId(resultSet.getInt("departmentId"));
                    user.setDepartmentName(resultSet.getString("departmentName"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM User WHERE userId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLIntegrityConstraintViolationException e) {
            // Log the exception for debugging
            System.err.println("Delete failed due to foreign key constraint: " + e.getMessage());
            throw new RuntimeException("Cannot delete user because they are assigned to other records.");
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
