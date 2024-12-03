<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="hospital.group.dbservice.FeatureService, hospital.group.dbservice.UserService, hospital.group.dbservice.FeatureMappingService" %>
<%@ page import="hospital.group.model.Feature, hospital.group.model.UserRole" %>
<%
    // Fetching features and user roles from the database
    FeatureService featureService = new FeatureService();
	UserService userService = new UserService();
	FeatureMappingService mappingService = new FeatureMappingService();
    
    List<Feature> features = featureService.getAllFeatures();
    List<UserRole> roles = userService.getAllRoles();
%>

<div class="container mt-1">
 <div class="card shadow">
  <div class="card-header bg-primary text-white">
            <h3 class="text-center">Feature Management</h3>
        </div>
        
        <div class="card-body">
	<form action="featureMapping" method="POST">
        <table border="1" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Feature Name</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Permissions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Feature feature : features) {
                %>
                <tr>
                    <td><%= feature.getFeatureName() %></td>
                    <td><%= feature.getDescription() %></td>
                    <td>
                        <input disabled type="checkbox" name="isActive" value="<%= feature.getIsActive() ? "TRUE" : "FALSE" %>" <%= feature.getIsActive() ? "checked" : "" %> />
                    </td>
                    <td>
                        <%
                            for (UserRole role : roles) {
                                // Fetch permissions for each role and feature combination
                                boolean canCreate = mappingService.hasPermissionForFeatureRole(feature.getFeatureId(), role.getRoleId(), "canCreate");
                                boolean canRead = mappingService.hasPermissionForFeatureRole(feature.getFeatureId(), role.getRoleId(), "canRead");
                                boolean canUpdate = mappingService.hasPermissionForFeatureRole(feature.getFeatureId(), role.getRoleId(), "canUpdate");
                                boolean canDelete = mappingService.hasPermissionForFeatureRole(feature.getFeatureId(), role.getRoleId(), "canDelete");
                        %>
                        <div>
						    <label><%= role.getRoleName() %>:</label>
						    <input type="checkbox" 
						           name="permissions_<%= feature.getFeatureId() %>_<%= role.getRoleId() %>_create" 
						           <%= canCreate ? "checked" : "" %> 
						           <% if ("Admin".equals(role.getRoleName()) || !feature.getIsActive()) { %> 
						               disabled="true" 
						           <% } %> /> Create
						
						    <input type="checkbox" 
						           name="permissions_<%= feature.getFeatureId() %>_<%= role.getRoleId() %>_read" 
						           <%= canRead ? "checked" : "" %> 
						           <% if ("Admin".equals(role.getRoleName()) || !feature.getIsActive()) { %> 
						               disabled="true" 
						           <% } %> /> Read
						
						    <input type="checkbox" 
						           name="permissions_<%= feature.getFeatureId() %>_<%= role.getRoleId() %>_update" 
						           <%= canUpdate ? "checked" : "" %> 
						           <% if ("Admin".equals(role.getRoleName()) || !feature.getIsActive()) { %> 
						               disabled="true" 
						           <% } %> /> Update
						
						    <input type="checkbox" 
						           name="permissions_<%= feature.getFeatureId() %>_<%= role.getRoleId() %>_delete" 
						           <%= canDelete ? "checked" : "" %> 
						           <% if ("Admin".equals(role.getRoleName()) || !feature.getIsActive()) { %> 
						               disabled="true" 
						           <% } %> /> Delete
						</div>

                        <%
                            }
                        %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <button type="submit" class="btn btn-primary btn-block">Save Changes</button>
    </form>
	</div>
	
	</div>
</div>
