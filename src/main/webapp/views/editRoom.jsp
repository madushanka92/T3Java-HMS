<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Room</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Edit Room Details</h2>

        <!-- Error Message if update failed -->
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>

        <!-- Form to edit room details -->
        <form action="${pageContext.request.contextPath}/editRoom" method="post">
            <!-- Hidden field for roomId to identify the room being edited -->
            <input type="hidden" name="roomId" value="${room.roomId}">

            <label for="roomNumber">Room Number:</label>
            <input type="text" id="roomNumber" name="roomNumber" value="${room.roomNumber}" required>

            <label for="roomType">Room Type:</label>
            <input type="text" id="roomType" name="roomType" value="${room.roomType}" required>

            <label for="availabilityStatus">Availability Status:</label>
            <input type="text" id="availabilityStatus" name="availabilityStatus" value="${room.availabilityStatus}" required>

            <label for="assignedPatientId">Assigned Patient ID:</label>
            <input type="text" id="assignedPatientId" name="assignedPatientId" value="${room.assignedPatientId}" placeholder="Optional">

            <label for="floorNumber">Floor Number:</label>
            <input type="number" id="floorNumber" name="floorNumber" value="${room.floorNumber}" required>

            <label for="departmentId">Department ID:</label>
            <input type="text" id="departmentId" name="departmentId" value="${room.departmentId}" required>

            <label for="lastCleanedAt">Last Cleaned At:</label>
            <input type="text" id="lastCleanedAt" name="lastCleanedAt" value="${room.lastCleanedAt}" required>

            <label for="dailyRate">Daily Rate:</label>
            <input type="number" id="dailyRate" name="dailyRate" value="${room.dailyRate}" step="0.01" required>

            <button type="submit">Update Room</button>
        </form>
    </div>
</body>
</html>
