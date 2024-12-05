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

           <div class="form-group">
    <label for="roomType">Room Type:</label>
    <select id="roomType" name="roomType" class="form-control" required>
        <option value="ICU" ${room.roomType == 'ICU' ? 'selected' : ''}>ICU</option>
        <option value="General" ${room.roomType == 'General' ? 'selected' : ''}>General</option>
        <option value="VIP" ${room.roomType == 'VIP' ? 'selected' : ''}>VIP</option>
    </select>
</div>
           

            
           <div class="form-group">
    <label for="availabilityStatus">Availability Status:</label>
    <select id="availabilityStatus" name="availabilityStatus" class="form-control" required>
        <option value="Available" ${room.availabilityStatus == 'Available' ? 'selected' : ''}>Available</option>
        <option value="Occupied" ${room.availabilityStatus == 'Occupied' ? 'selected' : ''}>Occupied</option>
        <option value="Maintenance" ${room.availabilityStatus == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
    </select>
</div>
           
            <label for="floorNumber">Floor Number:</label>
            <input type="number" id="floorNumber" name="floorNumber" value="${room.floorNumber}" required>

            
            <div class="form-group">
    <label for="departmentId">Department:</label>
    <select id="departmentId" name="departmentId" class="form-control" required>
        <option value="1" ${room.departmentId == '1' ? 'selected' : ''}>1. Surgical</option>
        <option value="2" ${room.departmentId == '2' ? 'selected' : ''}>2. ICU</option>
        <option value="3" ${room.departmentId == '3' ? 'selected' : ''}>3. ETU</option>
        <option value="4" ${room.departmentId == '4' ? 'selected' : ''}>4. OPD</option>
    </select>
</div>
            

            
            
             <div class="form-group">
            <label for="lastCleanedAt">Last Cleaned At:</label>
            <input type="text" id="lastCleanedAt" name="lastCleanedAt" value="${room.lastCleanedAt}" required class="form-control">
        </div>

            <label for="dailyRate">Daily Rate:</label>
            <input type="number" id="dailyRate" name="dailyRate" value="${room.dailyRate}" step="0.01" required>

            <button type="submit">Update Room</button>
            
            
        </form>
    </div>
   
</body>
 
</html>