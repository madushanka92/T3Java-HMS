<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="hospital.group.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="hospital.group.dbservice.UserService" %>
<%@ page import="hospital.group.model.Patient" %>

<%
    User loggedInUser = (User) request.getAttribute("loggedInUser");
    String roleName = (String) request.getAttribute("roleName");
    List<User> userList = (List<User>) request.getAttribute("userList"); // Fetching user list passed by servlet
    String selectedUserId = request.getParameter("userId"); // Get selected userId from the form submission
    User selectedUser = null;

    if (selectedUserId != null) {
        UserService userService = new UserService();
        selectedUser = userService.getUserById(Integer.parseInt(selectedUserId)); // Fetch the selected user details
    }

    List<Patient> patientList = (List<Patient>) request.getAttribute("patientList");
%>


    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<div class="container mt-4">
	<c:if test="${param.action == 'error'}">
	    <div class="alert alert-danger">An error occurred while creating the assignment. Please try again.</div>
	</c:if>

    <h2>Create Assignment</h2>
    <p><strong>Logged in as:</strong> <%= loggedInUser.getFirstName() + " " + loggedInUser.getLastName() %></p>
    <p><strong>Role:</strong> <%= roleName %></p>

    <form action="createAssignment" method="get" class="mt-4"> 
        <div class="mb-3">
            <label for="userId" class="form-label">Select User:</label>
            <select name="userId" id="userId" class="form-control searchable-dropdown" required>
                <option value="">-- Select User --</option>
                <%
                    for (User user : userList) {
                %>
                    <option value="<%= user.getUserId() %>" <%= selectedUser != null && selectedUser.getUserId() == user.getUserId() ? "selected" : "" %> >
                        <%= user.getFirstName() + " " + user.getLastName() %>
                    </option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="mb-3">
            <button type="submit" class="btn btn-primary">Select User</button>
        </div>
    </form>

    <%
        if (selectedUser != null) {
            String selectedRoleName = selectedUser.getRoleName();
    %>
 
    <form action="createAssignment" method="post" class="mt-4">
    	<input type="hidden" name="userId" value="<%= selectedUser != null ? selectedUser.getUserId() : "" %>">
    	<input type="hidden" name="selectedRoleName" value="<%= selectedUser != null ? selectedRoleName : "" %>">
    
        <div id="assignmentFields">
            <%
                if ("Doctor".equalsIgnoreCase(selectedRoleName)) {
            %>
                <div class="mb-3">
                    <label for="targetId" class="form-label">Select Patient:</label>
		            <select name="targetId" id="targetId" class="form-control searchable-dropdown" required>
		                <option value="">-- Select Patient --</option>
		                <c:forEach var="patient" items="${patientList}">
	                        <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
	                    </c:forEach>
		            </select>
                </div>

                <div class="mb-3">
                    <label for="notes" class="form-label">Notes:</label>
                    <textarea name="notes" id="notes" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label for="additionalDetails" class="form-label">Is Primary Doctor:</label>
                    <select name="additionalDetails" id="additionalDetails" class="form-control">
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>

            <%
                } else if ("Nurse".equalsIgnoreCase(selectedRoleName)) {
            %>
                <div class="mb-3">
                    <label for="targetId" class="form-label">Doctor ID:</label>
                    
                    <select name="targetId" id="targetId" class="form-control searchable-dropdown" required>
		                <option value="">-- Select Doctor --</option>
		                <c:forEach var="doctor" items="${doctorList}">
	                        <option value="${doctor.userId}">${doctor.firstName} ${doctor.lastName}</option>
	                    </c:forEach>
		            </select>
                </div>

                <div class="mb-3">
                    <label for="notes" class="form-label">Notes:</label>
                    <textarea name="notes" id="notes" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label for="additionalDetails" class="form-label">Shift Type:</label>
                    <select name="additionalDetails" id="additionalDetails" class="form-control">
                        <option value="Morning">Morning</option>
                        <option value="Afternoon">Afternoon</option>
                        <option value="Night">Night</option>
                        <option value="All Day">All Day</option>
                    </select>
                </div>

            <%
                } else if ("Technician".equalsIgnoreCase(selectedRoleName)) {
            %>
                <div class="mb-3">
				    <label for="assignmentType" class="form-label">Assignment Type:</label>
				    <select name="assignmentType" id="assignmentType" class="form-control" onchange="toggleDepartmentFields()">
				        <option value="Patient">Patient</option>
				        <option value="Department">Department</option>
				    </select>
				</div>
				
				<div id="patientFields">
				    <div class="mb-3">
				        <label for="patientTargetId" class="form-label">Select Patient:</label>
				        <select name="patientTargetId" id="patientTargetId" class="form-control searchable-dropdown" required>
				            <option value="">-- Select Patient --</option>
				            <c:forEach var="patient" items="${patientList}">
				                <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
				            </c:forEach>
				        </select>
				    </div>
				
				    <div class="mb-3">
				        <label for="patientNotes" class="form-label">Notes:</label>
				        <textarea name="patientNotes" id="patientNotes" class="form-control"></textarea>
				    </div>
				
				    <div class="mb-3">
				        <label for="patientServiceType" class="form-label">Service Type:</label>
				        <select name="patientServiceType" id="patientServiceType" class="form-control">
				            <option value="Lab">Lab</option>
				            <option value="Radiology">Radiology</option>
				            <option value="Cardiology">Cardiology</option>
				            <option value="Neurology">Neurology</option>
				            <option value="Respiratory">Respiratory</option>
				        </select>
				    </div>
				    
				    
				    <div class="mb-3">
				        <label for="scheduledDateTime" class="form-label">Scheduled Date:</label>
				        <input type="date" name="scheduledDateTime" id="scheduledDateTime" class="form-control" />
				    </div>
				</div>
				
				<div id="departmentFields" style="display: none;">
				    <div class="mb-3">
				        <label for="departmentTargetId" class="form-label">Select Department:</label>
				        <select name="departmentTargetId" id="departmentTargetId" class="form-control searchable-dropdown" required>
				            <option value="">-- Select Department --</option>
				            <c:forEach var="department" items="${departmentList}">
				                <option value="${department.departmentId}">${department.departmentName}</option>
				            </c:forEach>
				        </select>
				    </div>
				
				    <div class="mb-3">
				        <label for="departmentNotes" class="form-label">Notes:</label>
				        <textarea name="departmentNotes" id="departmentNotes" class="form-control"></textarea>
				    </div>
				
				    <div class="mb-3">
				        <label for="departmentWorkShift" class="form-label">Work Shift:</label>
				        <select name="departmentWorkShift" id="departmentWorkShift" class="form-control">
				            <option value="Morning">Morning</option>
				            <option value="Afternoon">Afternoon</option>
				            <option value="Night">Night</option>
				            <option value="Rotational">Rotational</option>
				        </select>
				    </div>
				
				    <div class="mb-3">
				        <label for="departmentStartDate" class="form-label">Start Date:</label>
				        <input type="date" name="departmentStartDate" id="departmentStartDate" class="form-control" />
				    </div>
				</div>
                

            <%
                }
            %>
        </div>

        <div class="mb-3">
            <button type="submit" class="btn btn-primary">Create Assignment</button>
        </div>
    </form>
    <%
        }
    %>
</div> 

<script>

	$(document).ready(function() {
	    $('#targetId').select2({
	        placeholder: "-- Select --",
	        allowClear: true
	    });
	    

	    var patientFields = document.getElementById("patientFields");
	    if(patientFields)
	    	toggleDepartmentFields();
	});

	function toggleDepartmentFields() {
		var assignmentType = document.getElementById("assignmentType").value;
	    console.log("Assignment Type Selected:", assignmentType);

	    var patientFields = document.getElementById("patientFields");
	    var departmentFields = document.getElementById("departmentFields");

	    // Force reset all fields
	    setFieldsDisabled(patientFields, true);
	    setFieldsDisabled(departmentFields, true);

	    if (assignmentType === "Department") {
	        departmentFields.style.display = "block";
	        patientFields.style.display = "none";
	        setFieldsDisabled(departmentFields, false);
	    } else {
	        departmentFields.style.display = "none";
	        patientFields.style.display = "block";
	        setFieldsDisabled(patientFields, false);
	    }
	    
	    console.log("Patient Fields Disabled: ", patientFields.querySelectorAll("input, select, textarea[disabled]").length > 0);
	    console.log("Department Fields Disabled: ", departmentFields.querySelectorAll("input, select, textarea[disabled]").length > 0);

	}
	
	function setFieldsDisabled(container, isDisabled) {
	    console.log("Container:", container); // Verify the container
	    var inputs = container.querySelectorAll("input, select, textarea");
	    console.log("Inputs Found:", inputs.length, "Disabled Status:", isDisabled); // Verify elements targeted and intended action
	    inputs.forEach(function (input) {
	        console.log("Setting disabled to", isDisabled, "for element:", input); // Log each action
	        input.disabled = isDisabled;
	    });
	}


</script>
