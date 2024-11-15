
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

public class departmentService {

    public List<Department> getAllDepartments() {
        List<Department> departmentList = new ArrayList<>();
        String query = "SELECT departmentId, departmentName, headOfDepartmentId FROM Department";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                // Use the constructor with parameters
                Department department = new Department(
                    rs.getInt("departmentId"),
                    rs.getString("departmentName"),
                    rs.getInt("headOfDepartmentId")
                );
                departmentList.add(department);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return departmentList;
    }

    public Department getDepartmentById(int departmentId) {
        Department department = null;
        String query = "SELECT departmentId, departmentName, headOfDepartmentId FROM Department WHERE departmentId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, departmentId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                // Use the constructor with parameters
                department = new Department(
                    rs.getInt("departmentId"),
                    rs.getString("departmentName"),
                    rs.getInt("headOfDepartmentId")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return department;
    }

    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT userId, firstName, lastName FROM Users"; // Adjust column names as needed

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                // Create User object with proper constructor
                User user = new User(
                    rs.getInt("userId"),
                    rs.getString("firstName"),
                    rs.getString("lastName"), query, query, 0, query, query, null
                );
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }

    public boolean deleteDepartment(int departmentId) {
        String query = "DELETE FROM Department WHERE departmentId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, departmentId);
            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0; // Returns true if at least one row was deleted
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Returns false if the deletion fails
    }

    public boolean updateDepartment(Department department) {
        String query = "UPDATE Department SET departmentName = ?, headOfDepartmentId = ? WHERE departmentId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, department.getDepartmentName());
            statement.setInt(2, department.getHeadOfDepartmentId());
            statement.setInt(3, department.getDepartmentId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0; // Returns true if update is successful
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // Returns false if update fails
    }

}
