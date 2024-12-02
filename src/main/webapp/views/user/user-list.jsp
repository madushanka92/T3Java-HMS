<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@page import="hospital.group.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<div class="container mt-5">
	<c:if test="${not empty param.successMessage}">
	    <div class="alert alert-success" role="alert">
	        ${param.successMessage}
	    </div>
	</c:if>
	<c:if test="${not empty param.errorMessage}">
	    <div class="alert alert-danger" role="alert">
	        ${param.errorMessage}
	    </div>
	</c:if>
	
   	<% if (permissions.containsKey(featureMap.get("User")) && 
      permissions.get(featureMap.get("User")).get("canCreate")) { %>
        <a href="create-user" class="btn btn-primary btn-lg">Add New User</a>
      <% } %>
        <h1 class="text-center mb-4">User List</h1>

        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">User ID</th>
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Role</th>
                        <th scope="col">Department</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>${user.email}</td>
                            <td>${user.roleName}</td>
                            <td>${user.departmentName}</td>
                            <td>
                                 <c:if test="${user.roleName != 'Admin'}">
                                 
								   	<% if (permissions.containsKey(featureMap.get("User")) && 
								      permissions.get(featureMap.get("User")).get("canDelete")) { %>
		                                <form action="delete-user" method="POST" onsubmit="return confirm('Are you sure you want to delete this user?');">
		                                    <input type="hidden" name="userId" value="${user.userId}">
		                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
		                                </form>
	                                 <% } else {%>
	                                 	<button type="submit" disabled class="btn btn-danger btn-sm">Delete</button>
	                                 <% } %>
	                                 
	                            </c:if>
	                            <c:if test="${user.roleName == 'Admin'}">
	                                <span class="text-muted">Cannot delete Admin</span>
	                            </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>