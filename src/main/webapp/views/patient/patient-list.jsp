<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@page import="hospital.group.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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

<link href="${pageContext.request.contextPath}/assets/css/viewPatient.css" rel="stylesheet">

<div class="container mt-1 view-patient">

   	<% if (permissions.containsKey(featureMap.get("Patient")) && 
      permissions.get(featureMap.get("Patient")).get("canCreate")) { %>
        <a href="create-patient" class="btn btn-primary btn-lg">Register New Patient</a>
      <% } %>
    <h1 class="text-center mb-4">Patient List</h1>

    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th scope="col">Patient ID</th>
                    <th scope="col">First Name</th>
                    <th scope="col">Last Name</th>
                    <th scope="col">Date of Birth</th>
                    <th scope="col">Gender</th>
                    <th scope="col">Contact Number</th>
                    <th scope="col">Email</th>
                    <th scope="col">Address</th>
                    <th scope="col">Emergency Contact</th>
                    <th scope="col">Medical History</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="patient" items="${patientList}">
                    <tr>
                        <td>${patient.patientId}</td>
                        <td>${patient.firstName}</td>
                        <td>${patient.lastName}</td>
                        <td>${patient.dateOfBirth}</td>
                        <td>${patient.gender}</td>
                        <td>${patient.contactNumber}</td>
                        <td>${patient.email}</td>
                        <td>${patient.address}</td>
                        <td>${patient.emergencyContact}</td>
                        <td>${patient.medicalHistory}</td>
                        <td>
                            <!-- Edit Button -->
                            
					   	<% if (permissions.containsKey(featureMap.get("Patient")) && 
					      permissions.get(featureMap.get("Patient")).get("canUpdate")) { %>
                            <a href="editPatient?id=${patient.patientId}" class="btn btn-primary btn-sm">Edit</a>
                         <% } %>
                            <!-- Delete Button with JavaScript confirmation -->
                            
                            
					   	<% if (permissions.containsKey(featureMap.get("Patient")) && 
					      permissions.get(featureMap.get("Patient")).get("canDelete")) { %>
                            <a href="javascript:void(0);" class="btn btn-danger btn-sm" onclick="confirmDelete(${patient.patientId})">Delete</a>
                         <% } %>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <c:if test="${empty patientList}">
        <p class="text-center mt-4">No patients found.</p>
    </c:if>
</div>

<script type="text/javascript">
    function confirmDelete(patientId) {
        // Show confirmation dialog
        var result = confirm("Are you sure you want to delete this patient?");
        if (result) {
            // If confirmed, redirect to deletePatient servlet with the patientId
            window.location.href = 'deletePatient?id=' + patientId;
        }
    }
</script>
