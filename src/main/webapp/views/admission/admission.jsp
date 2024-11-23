<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container admission-list">
    <h2>Admissions List</h2>
    <a href="admissionForm" class="btn btn-primary mt-2 mb-3">Add New Admission</a>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Patient</th>
            <th>Room</th>
            <th>Department</th>
            <th>Status</th>
            <th>Admission Date</th>
            <th>Discharge Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="admission" items="${admissions}">
            <tr>
                <td>${admission.admissionId}</td>
                <td>${admission.patientId}</td>
                <td>${admission.roomId == 0 ? "Waiting" : admission.roomId}</td>
                <td>${admission.departmentId}</td>
                <td>${admission.admissionStatus}</td>
                <td>${admission.admissionDate}</td>
                <td>${admission.dischargeDate != null ? admission.dischargeDate : "N/A"}</td>
                <td>
                    <a href="admissionForm?id=${admission.admissionId}" class="btn btn-secondary">Edit</a>
                    <a href="admissionDelete?id=${admission.admissionId}" class="btn btn-danger">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>