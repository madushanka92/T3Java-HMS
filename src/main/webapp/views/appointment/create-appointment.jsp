<%@ page import="java.util.*, hospital.group.model.User, hospital.group.model.Department" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-4">
    <h2 class="text-center mb-4">Create Appointment</h2>

    <form action="create-appointment" method="post">
        
        <!-- Patient ID Selection -->
        <div class="form-group">
            <label for="patientId">Patient:</label>
            <select name="patientId" id="patientId" class="form-control searchable-dropdown" required>
                <option value="">-- Select Patient --</option>
                <c:forEach var="patient" items="${patientList}">
                    <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Doctor Selection -->
        <div class="form-group">
            <label for="doctorId">Doctor:</label>
            <select id="doctorId" name="doctorId" class="form-control" required>
                <c:forEach var="doctor" items="${doctors}">
                    <option value="${doctor.userId}">${doctor.firstName} ${doctor.lastName}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Department Selection -->
        <div class="form-group">
            <label for="departmentId">Department:</label>
            <select id="departmentId" name="departmentId" class="form-control" required>
                <c:forEach var="department" items="${departments}">
                    <option value="${department.departmentId}">${department.departmentName}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Appointment Date -->
        <div class="form-group">
            <label for="appointmentDate">Appointment Date:</label>
            <input type="date" id="appointmentDate" name="appointmentDate" class="form-control" required>
        </div>

        <!-- Appointment Time -->
        <div class="form-group">
            <label for="appointmentTime">Appointment Time:</label>
            <input type="time" id="appointmentTime" name="appointmentTime" class="form-control" required>
        </div>

        <!-- Status Selection -->
        <div class="form-group">
            <label for="status">Status:</label>
            <select id="status" name="status" class="form-control" required>
                <option value="Scheduled">Scheduled</option>
                <option value="Completed">Completed</option>
                <option value="Canceled">Canceled</option>
            </select>
        </div>

        <!-- Appointment Type Selection -->
        <div class="form-group">
            <label for="type">Appointment Type:</label>
            <select id="type" name="type" class="form-control" required>
                <option value="Meeting">Meeting</option>
                <option value="In-Person">In-Person</option>
                <option value="Checkup">Checkup</option>
                <option value="Emergency">Emergency</option>
            </select>
        </div>

        <!-- Submit Button -->
        <div class="form-group text-center">
            <button type="submit" class="btn btn-success">Create Appointment</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function() {
        $('#patientId').select2({
            placeholder: "-- Select Patient --",
            allowClear: true
        });
    });
</script>