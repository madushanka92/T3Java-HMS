<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Report</title>

    <!-- Include Select2 CSS and JS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/createReport.css"> <!-- Custom CSS -->


    <div class="container">
        <h2>Create Medical Report</h2>

        <!-- Form for creating a new medical report -->
        <form action="${pageContext.request.contextPath}/createReport" method="POST">
            <!-- Patient Dropdown -->
            <div class="form-group">
                <label for="patientId">Select Patient</label>
                <select id="patientId" name="patientId" class="form-control searchable-dropdown" required>
                    <option value="">-- Select Patient --</option>
                    <c:forEach var="patient" items="${patientList}">
                        <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Medical Diagnosis -->
            <div class="form-group">
                <label for="diagnosis">Diagnosis</label>
                <input type="text" id="diagnosis" name="diagnosis" class="form-control" required>
            </div>

            <!-- Treatment -->
            <div class="form-group">
                <label for="treatment">Treatment</label>
                <textarea id="treatment" name="treatment" class="form-control" rows="3" required></textarea>
            </div>

            <!-- Date of Report -->
            <div class="form-group">
                <label for="reportDate">Date of Report</label>
                <input type="date" id="reportDate" name="reportDate" class="form-control" required>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Create Report</button>
            <a href="${pageContext.request.contextPath}/viewReport" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <!-- Initialize Select2 -->
    <script>
        $(document).ready(function() {
            $('#patientId').select2({
                placeholder: "-- Select Patient --",
                allowClear: true
            });
        });
    </script>
