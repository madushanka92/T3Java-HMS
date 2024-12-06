<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@page import="hospital.group.model.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%

	User loggedInUser = (User) session.getAttribute("loggedInUser");
	int roleId = loggedInUser.getRoleId();
	FeatureMappingService featureMappingService = new FeatureMappingService();
	FeatureService featureService = new FeatureService();
	
	// Get all feature permissions for the user's role
    Map<Integer, Map<String, Boolean>> permissions = featureMappingService.getFeaturePermissionsByRole(roleId);

    // Get feature names mapped to IDs
    Map<String, Integer> featureMap = featureService.getFeatureNameToIdMap();

%>

<div class="container">
        <h1>User Role List</h1>
        
		<% if (permissions.containsKey(featureMap.get("UserRoles")) && 
		      permissions.get(featureMap.get("UserRoles")).get("canCreate")) { %>
        <a href="create-userrole" class="btn btn-primary">Add New Role</a>
        
	 <% } %>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Role ID</th>
                    <th>Role Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="userRole" items="${userRoleList}">
                    <tr>
                        <td>${userRole.roleId}</td>
                        <td>${userRole.roleName}</td>
                        <td>        
							<% if (permissions.containsKey(featureMap.get("UserRoles")) && 
							      permissions.get(featureMap.get("UserRoles")).get("canUpdate")) { %>
                            		<a href="edit-userrole?id=${userRole.roleId}" class="btn btn-sm btn-primary">Edit</a>
                            <% } %>		
                            		        
							<% if (permissions.containsKey(featureMap.get("UserRoles")) && 
							      permissions.get(featureMap.get("UserRoles")).get("canDelete")) { %>
		                            <a href="delete-userrole?id=${userRole.roleId}" class="btn btn-sm btn-danger">Delete</a>
		                    <% } %>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
