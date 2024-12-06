<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Room</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-success text-white">
                <h2 class="mb-0">Create Room</h2>
            </div>
            <div class="card-body">
                <form method="post" action="createRoom">

                    <!-- Room Number -->
                    <div class="form-group">
                        <label for="roomNumber">Room Number:</label>
                        <input type="text" id="roomNumber" name="roomNumber" required class="form-control" placeholder="Enter Room Number">
                    </div>

                    <!-- Room Type -->
                    <div class="form-group">
                        <label for="roomType">Room Type:</label>
                        <select id="roomType" name="roomType" required class="form-control">
                            <option value="">-- Select Room Type --</option>
                            <option value="ICU">ICU</option>
                            <option value="General">General</option>
                            <option value="VIP">VIP</option>
                        </select>
                    </div>

                    <!-- Availability Status -->
                    <div class="form-group">
                        <label for="availabilityStatus">Availability Status:</label>
                        <select id="availabilityStatus" name="availabilityStatus" class="form-control">
                            <option value="Available">Available</option>
                            <option value="Occupied">Occupied</option>
                            <option value="Maintenance">Maintenance</option>
                        </select>
                    </div>

                    <!-- Floor Number -->
                    <div class="form-group">
                        <label for="floorNumber">Floor Number:</label>
                        <input type="number" id="floorNumber" name="floorNumber" required class="form-control" placeholder="Enter Floor Number">
                    </div>

                    <!-- Department -->
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

                    <!-- Last Cleaned At -->
                    <div class="form-group">
                        <label for="lastCleanedAt">Last Cleaned At:</label>
                        <input type="date" id="lastCleanedAt" name="lastCleanedAt" required class="form-control">
                    </div>

                    <!-- Daily Rate -->
                    <div class="form-group">
                        <label for="dailyRate">Daily Rate:</label>
                        <input type="number" step="0.01" id="dailyRate" name="dailyRate" required class="form-control" placeholder="Enter Daily Rate">
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-success btn-block">Create Room</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
