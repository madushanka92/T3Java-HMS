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

<div class="container admission-list">
    <h2>Admissions List</h2>
    
    
   	<% if (permissions.containsKey(featureMap.get("Admissions")) && 
      permissions.get(featureMap.get("Admissions")).get("canCreate")) { %>
    	<a href="admissionForm" class="btn btn-primary mt-2 mb-3">Add New Admission</a>
    <% } %>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Patient</th>
            <th>Room</th>
            <th>Department</th>
            <th>Status</th>
            <th>Admission Date</th>
            <th>Discharge Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
		    <c:forEach var="admission" items="${admissions}">
		        <tr>
		            <td>${admission.admissionId}</td>
		            <td>${admission.patientName}</td>
		            <td>${admission.roomNumber}</td>
		            <td>${admission.departmentName}</td>
		            <td>${admission.admissionStatus}</td>
		            <td>${admission.admissionDate}</td>
		            <td>${admission.dischargeDate != null ? admission.dischargeDate : "N/A"}</td>
		            <td>
		                <a href="admissionForm?id=${admission.admissionId}" class="btn btn-secondary">Edit</a>
		                <a href="admissionDelete?id=${admission.admissionId}" class="btn btn-danger">Delete</a>
		            </td>
		        </tr>
		    </c:forEach>
		</tbody>

    </table>
</div>