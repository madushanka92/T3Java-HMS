<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container">
    <h2>Create Room</h2>
    <form method="post" action="createRoom">
        

        <div class="form-group">
            <label for="roomNumber">Room Number:</label>
            <input type="text" id="roomNumber" name="roomNumber" required class="form-control">
        </div>
        
       

        <div class="form-group">
            <label for="roomType">Room Type:</label>
            <select id="roomType" name="roomType" required class="form-control">
            <option value="">-- Select Room Type --</option>
            <option value="ICU">ICU</option>
            <option value="General">General</option>
            <option value="VIP">VIP</option>
            </select>
        </div>

        <div class="form-group">
            <label for="availabilityStatus">Availability Status:</label>
            <select id="availabilityStatus" name="availabilityStatus" class="form-control">
                <option value="Available">Available</option>
                <option value="Occupied">Occupied</option>
                <option value="Maintenance">Maintenance</option>
            </select>
        </div>

        

        <div class="form-group">
            <label for="floorNumber">Floor Number:</label>
            <input type="number" id="floorNumber" name="floorNumber" required class="form-control">
        </div>

        
    <div class="form-group">
    <label for="departmentId">Department:</label>
    <select id="departmentId" name="departmentId" required class="form-control">
        <option value="">-- Select Department --</option>
        <option value="1">1. Surgical</option>
        <option value="2">2. ICU</option>
        <option value="3">3. ETU</option>
        <option value="4">4. OPD</option>
    </select>
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