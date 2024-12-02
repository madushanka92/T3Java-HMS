<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@page import="hospital.group.model.User"%>
<%@ page import="java.util.List" %>
<%@ page import="hospital.group.model.Appointment" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%

	User loggedInUser = (User) session.getAttribute("loggedInUser");
	int roleId = loggedInUser.getRoleId();
	FeatureMappingService featureMappingService = new FeatureMappingService();
	FeatureService featureService = new FeatureService();
	
	// Get all feature permissions for the user's role
    Map<Integer, Map<String, Boolean>> permissions = featureMappingService.getFeaturePermissionsByRole(roleId);

    // Get feature names mapped to IDs
    Map<String, Integer> featureMap = featureService.getFeatureNameToIdMap();

%>

<div class="container mt-4">
    <h2 class="text-center mb-4">Appointments</h2>

    <!-- Table for displaying appointments -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Appointment ID</th>
                    <th>Patient</th>
                    <th>Department</th>
                    <th>Appointment Date</th>
                    <th>Appointment Time</th>
                    <th>Status</th>
                    <th>Type</th>
                    <th>Action</th> <!-- Added column for action button -->
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
                    if (appointments != null && !appointments.isEmpty()) {
                        for (Appointment appointment : appointments) {
                %>
                    <tr>
                        <td><%= appointment.getAppointmentId() %></td>
                        <td><%= appointment.getPatientFirstName() + " " + appointment.getPatientLastName() %></td>
                        <td><%= appointment.getDepartmentName() %></td>
                        <td><%= appointment.getAppointmentDate() %></td>
                        <td><%= appointment.getAppointmentTime() %></td>
                        <td><%= appointment.getStatus() %></td>
                        <td><%= appointment.getType() %></td>
                        <td>
                        <% if (permissions.containsKey(featureMap.get("Appointments")) && 
   							permissions.get(featureMap.get("Appointments")).get("canUpdate")) { %>
                            <!-- Form to mark appointment as completed -->
                            <form action="markAsCompleted" method="POST">
                                <input type="hidden" name="appointmentId" value="<%= appointment.getAppointmentId() %>">
                                <input type="hidden" name="doctorId" value="<%= appointment.getDoctorId() %>">
                                <button type="submit" class="btn btn-primary" <%= (appointment.getStatus().equals("Completed") ? "disabled" : "") %> >
                                    <%= (appointment.getStatus().equals("Completed") ? "Completed" : "Mark as Completed") %>
                                </button>
                            </form>
                             
      					<% } %>
                        </td>
                    </tr>
                <% 
                        }
                    } else {
                %>
                    <tr><td colspan="8" class="text-center">No appointments found.</td></tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

