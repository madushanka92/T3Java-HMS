<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@page import="hospital.group.model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/viewDepartment.css">

<div class="view-department">

<div class="container">
	
	
   	<% if (permissions.containsKey(featureMap.get("Department")) && 
      permissions.get(featureMap.get("Department")).get("canCreate")) { %>
    	<a href="create-department" class="btn btn-primary btn-lg">Add New Department</a>
     <% } %>
    <h2>Department List</h2>
    
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Department ID</th>
                <th>Department Name</th>
                <th>Head of Department ID</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="department" items="${departmentList}">
                <tr>
                    <td>${department.departmentId}</td>
                    <td>${department.departmentName}</td>
                    <td>${department.headOfDepartmentId}</td>
                    <td>
                        <!-- Edit Button -->
                        
					   	<% if (permissions.containsKey(featureMap.get("Department")) && 
					      permissions.get(featureMap.get("Department")).get("canUpdate")) { %>
                        	<a href="${pageContext.request.contextPath}/edit-department?id=${department.departmentId}" 
                           class="btn btn-sm btn-primary">Edit</a>
                          <% } %>
                        
                        <!-- Delete Button with Confirmation -->
                        
					   	<% if (permissions.containsKey(featureMap.get("Department")) && 
					      permissions.get(featureMap.get("Department")).get("canDelete")) { %>
	                        <a href="javascript:void(0);" 
	                           class="btn btn-sm btn-danger" 
	                           onclick="confirmDelete(${department.departmentId})">Delete</a>
                          <% } %>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<c:if test="${empty departmentList}">
    <p class="text-center">No departments found.</p>
</c:if>

<script type="text/javascript">
    function confirmDelete(departmentId) {
        // Show confirmation dialog
        const confirmation = confirm("Are you sure you want to delete this department?");
        if (confirmation) {
            // Redirect to deleteDepartment servlet if confirmed
            window.location.href = '${pageContext.request.contextPath}/deleteDepartment?id=' + departmentId;
        }
    }
</script>
</div>
