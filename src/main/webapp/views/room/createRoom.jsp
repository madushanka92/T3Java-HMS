<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container">
    <h2>Create Room</h2>
    <form method="post" action="createRoom">
        <div class="form-group">
            <label for="roomId">Room ID:</label>
            <input type="text" id="roomId" name="roomId" required class="form-control">
        </div>

        <div class="form-group">
            <label for="roomNumber">Room Number:</label>
            <input type="text" id="roomNumber" name="roomNumber" required class="form-control">
        </div>

        <div class="form-group">
            <label for="roomType">Room Type:</label>
            <input type="text" id="roomType" name="roomType" required class="form-control">
        </div>

        <div class="form-group">
            <label for="availabilityStatus">Availability Status:</label>
            <select id="availabilityStatus" name="availabilityStatus" class="form-control">
                <option value="Available">Available</option>
                <option value="Occupied">Occupied</option>
                <option value="Under Maintenance">Under Maintenance</option>
            </select>
        </div>

        <div class="form-group">
            <label for="assignedPatientId">Assigned Patient ID:</label>
            <input type="text" id="assignedPatientId" name="assignedPatientId" class="form-control">
        </div>

        <div class="form-group">
            <label for="floorNumber">Floor Number:</label>
            <input type="number" id="floorNumber" name="floorNumber" required class="form-control">
        </div>

        <div class="form-group">
            <label for="departmentId">Department ID:</label>
            <input type="text" id="departmentId" name="departmentId" required class="form-control">
        </div>

        <div class="form-group">
            <label for="lastCleanedAt">Last Cleaned At:</label>
            <input type="date" id="lastCleanedAt" name="lastCleanedAt" required class="form-control">
        </div>

        <div class="form-group">
            <label for="dailyRate">Daily Rate:</label>
            <input type="number" step="0.01" id="dailyRate" name="dailyRate" required class="form-control">
        </div>

        <button type="submit" class="btn btn-primary">Create Room</button>
    </form>
</div>