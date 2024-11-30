<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <h2>View Rooms</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Room ID</th>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Availability</th>
                <th>Assigned Patient</th>
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
                        <td>${room.assignedPatientId}</td>
                        <td>${room.floorNumber}</td>
                        <td>${room.departmentId}</td>
                        <td>${room.lastCleanedAt}</td>
                        <td>${room.dailyRate}</td>
                        <td>
                            <a href="editRoom?roomId=${room.roomId}" class="btn btn-warning btn-sm">Edit</a>
                            <!-- Redirect to deleteRoom.jsp -->
                            <a href="${pageContext.request.contextPath}/deleteRoom?roomId=${room.roomId}" 
                               class="btn btn-danger btn-sm">Delete</a>
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
