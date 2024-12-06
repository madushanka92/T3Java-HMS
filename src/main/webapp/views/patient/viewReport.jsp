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

    <div class="container">
    	
    	<% if (permissions.containsKey(featureMap.get("PatientRecords")) && 
	           permissions.get(featureMap.get("PatientRecords")).get("canCreate")) { %>
        		<a href="createReport" class="btn btn-primary mb-4">Add New Record</a>
         <% } %>
        
        <h2>View Medical Reports</h2>

        <!-- Patient Selection Form -->
        <form action="${pageContext.request.contextPath}/viewReport" method="GET">
            <div class="form-group">
                <label for="patientId">Select Patient</label>
                <select id="patientId" name="patientId" class="form-control" required>
                    <option value="">-- Select Patient --</option>
                    <c:forEach var="patient" items="${patientList}">
                        <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
                    </c:forEach>
                </select>
            </div>
            
    	<% if (permissions.containsKey(featureMap.get("PatientRecords")) && 
	           permissions.get(featureMap.get("PatientRecords")).get("canRead")) { %>
	           
            <button type="submit" class="btn btn-primary">View Reports</button>
            <% } %>
        </form>

        <!-- Reports Table -->
        <div class="reports-section">
            <h3>Reports</h3>
            <c:if test="${not empty reports}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Report ID</th>
                            <th>Diagnosis</th>
                            <th>Treatment</th>
                            <th>Report Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="report" items="${reports}">
                            <tr>
                                <td>${report.reportId}</td>
                                <td>${report.diagnosis}</td>
                                <td>${report.treatment}</td>
                                <td>${report.reportDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty reports}">
                <p>No reports found for the selected patient.</p>
            </c:if>
        </div>
    </div>


