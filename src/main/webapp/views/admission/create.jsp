<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container create-admission">
    <h2>${admission.admissionId > 0 ? "Edit Admission" : "Create Admission"}</h2>
    <form action="admissionForm" method="post">
        <input type="hidden" name="admissionId" value="${admission.admissionId}">

        <div class="form-group">
		    <label for="patientId">Patient ID:</label>
		    <select id="patientId" name="patientId" class="form-control" required>
		        <option value="" disabled selected>Select a Patient</option> <!-- Prompt user to select -->
		        <c:forEach var="patient" items="${patients}">
		            <option value="${patient.patientId}" 
		                    ${admission != null && admission.patientId == patient.patientId ? 'selected' : ''}>
		                ${patient.firstName}
		            </option>
		        </c:forEach>
		    </select>
		</div>

        <div class="form-group">
            <label for="roomId">Room ID:</label>
            <input type="number" id="roomId" name="roomId" value="${admission.roomId}" class="form-control" placeholder="Leave empty for 'Pending'">
        </div>
        
        <div class="form-group">
		    <label for="departmentId">Department:</label>
		    <select id="departmentId" name="departmentId" class="form-control" required>
		        <option value="" disabled selected>Select a Department</option> <!-- Prompt user to select -->
		        <c:forEach var="department" items="${departments}">
		            <option value="${department.departmentId}" 
		                    ${admission != null && admission.departmentId == department.departmentId ? 'selected' : ''}>
		                ${department.departmentName}
		            </option>
		        </c:forEach>
		    </select>
		</div>

        <div class="form-group">
            <label for="admissionStatus">Status:</label>
            <select id="admissionStatus" name="admissionStatus" class="form-control">
                <option value="Active" ${admission.admissionStatus == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Discharged" ${admission.admissionStatus == 'Discharged' ? 'selected' : ''}>Discharged</option>
                <option value="Transferred" ${admission.admissionStatus == 'Transferred' ? 'selected' : ''}>Transferred</option>
                <option value="Pending" ${admission.admissionStatus == 'Pending' ? 'selected' : ''}>Pending</option>
            </select>
        </div>

        <div class="form-group">
            <label for="admissionDate">Admission Date:</label>
            <input type="datetime-local" id="admissionDate" name="admissionDate" value="${admission.admissionDate}" required class="form-control">
        </div>

        <div class="form-group">
            <label for="dischargeDate">Discharge Date:</label>
            <input type="datetime-local" id="dischargeDate" name="dischargeDate" value="${admission.dischargeDate}" class="form-control">
        </div>

        <div class="form-group">
            <label for="notes">Notes:</label>
            <textarea id="notes" name="notes" class="form-control">${admission.notes}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Save Admission</button>
    </form>
</div>