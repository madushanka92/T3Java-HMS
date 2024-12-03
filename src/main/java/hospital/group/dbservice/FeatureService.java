package hospital.group.dbservice;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Feature;

public class FeatureService {

	public List<Feature> getAllFeatures() {

        List<Feature> features = new ArrayList<>();
        String query = "SELECT * FROM Feature";
        try (Connection connection = DatabaseConnection.connect();
        		PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet result = stmt.executeQuery()) {
            while (result.next()) {
                features.add(new Feature(
                		result.getInt("featureId"),
                		result.getString("featureName"),
                		result.getString("description"),
                		result.getBoolean("isActive"),
                		result.getTimestamp("createdAt"),
                		result.getTimestamp("updatedAt")
                ));
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return features;

    }

	public void addFeature(Feature feature) throws SQLException {
        String query = "INSERT INTO Feature (featureName, description, isActive) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query , Statement.RETURN_GENERATED_KEYS)) {
        	connection.setAutoCommit(false);

        	statement.setString(1, feature.getFeatureName());
        	statement.setString(2, feature.getDescription());
        	statement.setBoolean(3, feature.getIsActive());
        	statement.executeUpdate();

        	ResultSet generatedKeys = statement.getGeneratedKeys();
            int featureId = -1;
            if (generatedKeys.next()) {
                featureId = generatedKeys.getInt(1);
            }

            String admingQuery = "SELECT roleId FROM UserRole WHERE roleName = 'Admin'";
            PreparedStatement roleStatement = connection.prepareStatement(admingQuery);
            ResultSet roleResult = roleStatement.executeQuery();

            if (roleResult.next()) {
                int roleId = roleResult.getInt("roleId");

                String fmappingQuery = "INSERT INTO FeatureMapping (featureId, roleId, canCreate, canRead, canUpdate, canDelete) VALUES (?, ?, ?, ?, ?, ?)";

                try (PreparedStatement featureMappingStatement = connection.prepareStatement(fmappingQuery)) {
                    featureMappingStatement.setInt(1, featureId);
                    featureMappingStatement.setInt(2, roleId);
                    featureMappingStatement.setBoolean(3, true); // canCreate
                    featureMappingStatement.setBoolean(4, true); // canRead
                    featureMappingStatement.setBoolean(5, true); // canUpdate
                    featureMappingStatement.setBoolean(6, true); // canDelete
                    featureMappingStatement.executeUpdate();
                }
            }
            connection.commit();

        }
    }

	public Feature findFeatureById(int featureId) {
        Feature feature = null;
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM Feature WHERE featureId = ?")) {
            statement.setInt(1, featureId);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                feature = new Feature(
                		result.getInt("featureId"),
                		result.getString("featureName"),
                		result.getString("description"),
                		result.getBoolean("isActive"),
                		result.getTimestamp("createdAt"),
                		result.getTimestamp("updatedAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feature;
    }

	public boolean updateFeature(Feature feature) {
        boolean isUpdated = false;
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE Feature SET featureName = ?, description = ?, isActive = ? WHERE featureId = ?")) {
            statement.setString(1, feature.getFeatureName());
            statement.setString(2, feature.getDescription());
            statement.setBoolean(3, feature.getIsActive());
            statement.setInt(4, feature.getFeatureId());

            isUpdated = (statement.executeUpdate() > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

	public boolean toggleFeatureStatus(int featureId, boolean isActive) throws SQLException {
        boolean isUpdated = false;
        String query = "UPDATE Feature SET isActive=? WHERE featureId=?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setBoolean(1, isActive);
        	statement.setInt(2, featureId);
            isUpdated = (statement.executeUpdate() > 0);
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

	 public boolean deleteFeature(int featureId) throws SQLException {
	        boolean isUpdated = false;
	        String query = "DELETE FROM Feature WHERE featureId=?";
	        try (Connection connection = DatabaseConnection.connect();
	             PreparedStatement statement = connection.prepareStatement(query)) {
	        	statement.setInt(1, featureId);
	        	isUpdated = (statement.executeUpdate() > 0);
	        }
	     	return isUpdated;
	    }

	 public Map<String, Integer> getFeatureNameToIdMap() throws SQLException {
		    String query = "SELECT featureId, featureName FROM Feature Where isActive = 1";
		    Map<String, Integer> featureMap = new HashMap<>();

		    try (Connection connection = DatabaseConnection.connect();
		         PreparedStatement statement = connection.prepareStatement(query);
		         ResultSet resultSet = statement.executeQuery()) {
		        while (resultSet.next()) {
		            featureMap.put(resultSet.getString("featureName"), resultSet.getInt("featureId"));
		        }
		    }
		    return featureMap;
		}
}
