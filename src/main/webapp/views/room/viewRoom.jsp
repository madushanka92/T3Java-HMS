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
		<% if (permissions.containsKey(featureMap.get("Rooms")) && 
		      permissions.get(featureMap.get("Rooms")).get("canCreate")) { %>
			<a href="createRoom" class="btn btn-primary btn-lg">Add New Room</a>
	 <% } %>
    <h2>View Rooms</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Room ID</th>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Availability</th>
                <th>Floor</th>
                <th>Department</th>
                <th>Last Cleaned</th>
                <th>Daily Rate</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${not empty rooms}">
                <c:forEach var="room" items="${rooms}">
                    <tr>
                        <td>${room.roomId}</td>
                        <td>${room.roomNumber}</td>
                        <td>${room.roomType}</td>
                        <td>${room.availabilityStatus}</td>
                        <td>${room.floorNumber}</td>
                        <td>${room.departmentId}</td>
                        <td>${room.lastCleanedAt}</td>
                        <td>${room.dailyRate}</td>
                        <td>
	                        <% if (permissions.containsKey(featureMap.get("Rooms")) && 
			      				permissions.get(featureMap.get("Rooms")).get("canUpdate")) { %>
                            		<a href="editRoom?roomId=${room.roomId}" class="btn btn-warning btn-sm">Edit</a>
                             <% } %>
                            <!-- Redirect to deleteRoom.jsp -->
	                        <% if (permissions.containsKey(featureMap.get("Rooms")) && 
			      				permissions.get(featureMap.get("Rooms")).get("canDelete")) { %>
                            <a href="${pageContext.request.contextPath}/deleteRoom?roomId=${room.roomId}" 
                               class="btn btn-danger btn-sm">Delete</a>
                             <% } %>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty rooms}">
                <tr><td colspan="10">No rooms available</td></tr>
            </c:if>
        </tbody>
    </table>
</div>