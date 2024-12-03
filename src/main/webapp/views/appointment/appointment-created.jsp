<%@ page import="hospital.group.model.Appointment" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!-- Container for the page layout -->
<div class="container mt-4">
    <h2 class="text-center mb-4">Appointment Confirmation</h2>
    
    <!-- Card for displaying appointment details -->
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Appointment Details</h5>
            <hr>
            
            <!-- Display appointment information in a table -->
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>Appointment ID</th>
                        <td>${appointment.appointmentId}</td>
                    </tr>
                    <tr>
                        <th>Patient ID</th>
                        <td>${appointment.patientId}</td>
                    </tr>
                    <tr>
                        <th>Doctor ID</th>
                        <td>${appointment.doctorId}</td>
                    </tr>
                    <tr>
                        <th>Department ID</th>
                        <td>${appointment.departmentId}</td>
                    </tr>
                    <tr>
                        <th>Appointment Date</th>
                        <td>${appointment.appointmentDate}</td>
                    </tr>
                    <tr>
                        <th>Appointment Time</th>
                        <td>${appointment.appointmentTime}</td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>${appointment.status}</td>
                    </tr>
                    <tr>
                        <th>Appointment Type</th>
                        <td>${appointment.type}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Return to Appointment List Button -->
    <div class="text-center mt-4">
        <a href="create-appointment" class="btn btn-primary">Back</a>
    </div>
</div>

<!-- Include Bootstrap JS and CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
