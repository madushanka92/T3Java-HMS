<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${pageContext.request.contextPath}/assets/css/editPatient.css" rel="stylesheet">

<div class="edit-patient">

<h1>Edit Patient</h1>
<form action="updatePatient" method="post">
    <input type="hidden" name="patientId" value="${patient.patientId}"/> <!-- Hidden ID -->
    <label>First Name:</label>
    <input type="text" name="firstName" value="${patient.firstName}" required/><br/>
    <label>Last Name:</label>
    <input type="text" name="lastName" value="${patient.lastName}" required/><br/>
    <label>Date of Birth:</label>
    <input type="date" name="dateOfBirth" value="${patient.dateOfBirth}" required/><br/>
    <label>Gender:</label>
    <input type="text" name="gender" value="${patient.gender}" required/><br/>
    <label>Contact Number:</label>
    <input type="text" name="contactNumber" value="${patient.contactNumber}" required/><br/>
    <label>Email:</label>
    <input type="email" name="email" value="${patient.email}" required/><br/>
    <label>Address:</label>
    <input type="text" name="address" value="${patient.address}" required/><br/>
    <label>Emergency Contact:</label>
    <input type="text" name="emergencyContact" value="${patient.emergencyContact}" required/><br/>
    <label>Medical History:</label>
    <textarea name="medicalHistory" required>${patient.medicalHistory}</textarea><br/>
    <input type="submit" value="Update Patient"/>
</form>

</div>