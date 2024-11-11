<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="${pageContext.request.contextPath}/assets/css/viewPatient.css" rel="stylesheet">

<h1>Patient List</h1>

<table>
    <thead>
        <tr>
            <th>Patient ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>Gender</th>
            <th>Contact Number</th>
            <th>Email</th>
            <th>Address</th>
            <th>Emergency Contact</th>
            <th>Medical History</th>
            <th>Actions</th> <!-- Added Actions column -->
        </tr>
    </thead>
    <tbody>
        <c:forEach var="patient" items="${patientList}">
            <tr>
                <td>${patient.patientId}</td>
                <td>${patient.firstName}</td>
                <td>${patient.lastName}</td>
                <td>${patient.dateOfBirth}</td>
                <td>${patient.gender}</td>
                <td>${patient.contactNumber}</td>
                <td>${patient.email}</td>
                <td>${patient.address}</td>
                <td>${patient.emergencyContact}</td>
                <td>${patient.medicalHistory}</td>
                <td>
                    <!-- Edit Button -->
                    <a href="editPatient?id=${patient.patientId}" class="btn btn-primary">Edit</a>
                    <!-- Delete Button with JavaScript confirmation -->
                    <a href="javascript:void(0);" class="btn btn-danger" onclick="confirmDelete(${patient.patientId})">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${empty patientList}">
    <p>No patients found.</p>
</c:if>

<script type="text/javascript">
    function confirmDelete(patientId) {
        // Show confirmation dialog
        var result = confirm("Are you sure you want to delete this patient?");
        if (result) {
            // If confirmed, redirect to deletePatient servlet with the patientId
            window.location.href = 'deletePatient?id=' + patientId;
        }
    }
</script>
