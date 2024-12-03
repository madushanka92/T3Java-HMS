package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import hospital.group.db.DatabaseConnection;

public class FeatureMappingService {

	public boolean hasPermissionForFeatureRole(int featureId, int roleId, String permissionType) throws SQLException {
	    // List of valid column names
	    List<String> validPermissions = Arrays.asList("canCreate", "canRead", "canUpdate", "canDelete");

	    // Check if permissionType is valid
	    if (!validPermissions.contains(permissionType)) {
	        throw new IllegalArgumentException("Invalid permission type: " + permissionType);
	    }

	    // SQL query to get the specific permission value
	    String sql = "SELECT " + permissionType + " FROM FeatureMapping WHERE featureId = ? AND roleId = ?";
	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(sql)) {

	        statement.setInt(1, featureId);
	        statement.setInt(2, roleId);

	        ResultSet result = statement.executeQuery();

	        if (result.next()) {
	            return result.getBoolean(permissionType); // Return the permission value
	        }
	        return false; // If no result is found, return false
	    }
	}

	public void updateFeaturePermissions(int featureId, int roleId, boolean canCreate, boolean canRead, boolean canUpdate, boolean canDelete) throws SQLException {
        String sql = "REPLACE INTO FeatureMapping (featureId, roleId, canCreate, canRead, canUpdate, canDelete, updatedAt) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statment = connection.prepareStatement(sql)) {
        	statment.setInt(1, featureId);
        	statment.setInt(2, roleId);
        	statment.setBoolean(3, canCreate);
        	statment.setBoolean(4, canRead);
        	statment.setBoolean(5, canUpdate);
        	statment.setBoolean(6, canDelete);
        	statment.executeUpdate();
        }
    }

	public Map<Integer, Map<String, Boolean>> getFeaturePermissionsByRole(int roleId) throws SQLException {
	    String query = "SELECT featureId, canCreate, canRead, canUpdate, canDelete FROM FeatureMapping WHERE roleId = ?";
	    Map<Integer, Map<String, Boolean>> permissions = new HashMap<>();

	    try (Connection connection = DatabaseConnection.connect();
	         PreparedStatement statement = connection.prepareStatement(query)) {
	        statement.setInt(1, roleId);
	        ResultSet resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            Map<String, Boolean> featurePermissions = new HashMap<>();
	            featurePermissions.put("canCreate", resultSet.getBoolean("canCreate"));
	            featurePermissions.put("canRead", resultSet.getBoolean("canRead"));
	            featurePermissions.put("canUpdate", resultSet.getBoolean("canUpdate"));
	            featurePermissions.put("canDelete", resultSet.getBoolean("canDelete"));

	            permissions.put(resultSet.getInt("featureId"), featurePermissions);
	        }
	    }
	    return permissions;
	}

}
