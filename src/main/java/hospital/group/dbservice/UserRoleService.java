package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.UserRole;

public class UserRoleService {

	public List<UserRole> getAllUserRoles() {
        List<UserRole> userRoleList = new ArrayList<>();
        String query = "SELECT * FROM UserRole";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                UserRole userRole = new UserRole(rs.getInt("roleId"), rs.getString("roleName"));
                userRoleList.add(userRole);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userRoleList;
    }

    public UserRole getUserRoleById(int roleId) {
        UserRole userRole = null;
        String query = "SELECT * FROM UserRole WHERE roleId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, roleId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                userRole = new UserRole(rs.getInt("roleId"), rs.getString("roleName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userRole;
    }

    public boolean createUserRole(UserRole userRole) {
        String query = "INSERT INTO UserRole (roleName) VALUES (?)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, userRole.getRoleName());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserRole(UserRole userRole) {
        String query = "UPDATE UserRole SET roleName = ? WHERE roleId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, userRole.getRoleName());
            statement.setInt(2, userRole.getRoleId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUserRole(int roleId) {
        String query = "DELETE FROM UserRole WHERE roleId = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, roleId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
