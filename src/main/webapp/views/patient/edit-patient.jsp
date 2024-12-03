<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="text-center">Edit Patient</h3>
        </div>
        <div class="card-body">
            <form action="updatePatient" method="post">
                <!-- Hidden ID -->
                <input type="hidden" name="patientId" value="${patient.patientId}" />

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="firstName" class="form-label">First Name:</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="${patient.firstName}" required>
                    </div>
                    <div class="col-md-6">
                        <label for="lastName" class="form-label">Last Name:</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="${patient.lastName}" required>
                    </div>

                    <div class="col-md-6">
                        <label for="dateOfBirth" class="form-label">Date of Birth:</label>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${patient.dateOfBirth}" required>
                    </div>
                    <div class="col-md-6">
                        <label for="gender" class="form-label">Gender:</label>
                        <select class="form-control" id="gender" name="gender" required>
                            <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="contactNumber" class="form-label">Contact Number:</label>
                        <input type="text" class="form-control" id="contactNumber" name="contactNumber" value="${patient.contactNumber}" required>
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="${patient.email}" required>
                    </div>

                    <div class="col-md-6">
                        <label for="address" class="form-label">Address:</label>
                        <textarea class="form-control" id="address" name="address" rows="2" required>${patient.address}</textarea>
                    </div>
                    <div class="col-md-6">
                        <label for="emergencyContact" class="form-label">Emergency Contact:</label>
                        <input type="text" class="form-control" id="emergencyContact" name="emergencyContact" value="${patient.emergencyContact}" required>
                    </div>

                    <div class="col-12">
                        <label for="medicalHistory" class="form-label">Medical History:</label>
                        <textarea class="form-control" id="medicalHistory" name="medicalHistory" rows="3" required>${patient.medicalHistory}</textarea>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Update Patient</button>
                    <a href="viewPatient" class="btn btn-secondary ms-2">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
