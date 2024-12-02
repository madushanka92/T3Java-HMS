<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/viewReports.css">
</head>
<body>
    <div class="container">
        <h2>View Medical Reports</h2>

        <!-- Patient Selection Form -->
        <form action="${pageContext.request.contextPath}/viewReport" method="GET">
            <div class="form-group">
                <label for="patientId">Select Patient</label>
                <select id="patientId" name="patientId" class="form-control" required>
                    <option value="">-- Select Patient --</option>
                    <c:forEach var="patient" items="${patientList}">
                        <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">View Reports</button>
        </form>

        <!-- Reports Table -->
        <div class="reports-section">
            <h3>Reports</h3>
            <c:if test="${not empty reports}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Report ID</th>
                            <th>Diagnosis</th>
                            <th>Treatment</th>
                            <th>Report Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="report" items="${reports}">
                            <tr>
                                <td>${report.reportId}</td>
                                <td>${report.diagnosis}</td>
                                <td>${report.treatment}</td>
                                <td>${report.reportDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty reports}">
                <p>No reports found for the selected patient.</p>
            </c:if>
        </div>
    </div>
</body>
</html>
