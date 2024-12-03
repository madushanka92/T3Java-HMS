<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@page import="hospital.group.model.User"%>
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

<header>
   <nav class="navbar navbar-expand-lg navbar-light bg-body-tertiary header-container">
            <div class="container">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav me-auto">
                    
                        <li class="nav-item">
                          <% if (permissions.containsKey(featureMap.get("Appointments")) && 
           					permissions.get(featureMap.get("Appointments")).get("canCreate")) { %>
                            	<a class="nav-link" href="${pageContext.request.contextPath}/create-appointment">Appointment</a>
                       		<% } %>
                        </li>
                        
                        <li class="nav-item dropdown">
                        
                        <% if (permissions.containsKey(featureMap.get("Assignment")) && 
	           			  permissions.get(featureMap.get("Assignment")).get("canRead")) { %>
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Assignment
                            </a>
                          <% } %>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li>
	                                <% if (permissions.containsKey(featureMap.get("Assignment")) && 
							           permissions.get(featureMap.get("Assignment")).get("canCreate")) { %>
	                                	<a class="dropdown-item" href="${pageContext.request.contextPath}/createAssignment">New Record</a>
							    	<% } %>
                               	</li>
                                <li>
	                                <% if (permissions.containsKey(featureMap.get("DoctorPatient")) && 
							           permissions.get(featureMap.get("DoctorPatient")).get("canRead")) { %>
                                		<a class="dropdown-item" href="${pageContext.request.contextPath}/listDoctorPatientAssignments">Doctor Patient</a>
							    	<% } %>
                               	</li>
                                <li>
	                                <% if (permissions.containsKey(featureMap.get("NurseDoctor")) && 
							           permissions.get(featureMap.get("NurseDoctor")).get("canRead")) { %>
                                		<a class="dropdown-item" href="${pageContext.request.contextPath}/listNurseDoctorAssignments">Nurse Doctor</a>
							    	<% } %>
                               	</li>
                                <li>
	                                <% if (permissions.containsKey(featureMap.get("TechnicianPatient")) && 
							           permissions.get(featureMap.get("TechnicianPatient")).get("canRead")) { %>
                                		<a class="dropdown-item" href="${pageContext.request.contextPath}/listTechnicianPatientAssignment">Technician Patient</a>
							    	<% } %>
                               	</li>
                                <li>
	                                <% if (permissions.containsKey(featureMap.get("TechnicianDepartment")) && 
							           permissions.get(featureMap.get("TechnicianDepartment")).get("canRead")) { %>
                                		<a class="dropdown-item" href="${pageContext.request.contextPath}/listTechnicianDepartmentAssignments">Technician Department</a>
							    	<% } %>
                               	</li>
                            </ul>
                        </li>
                        <%-- <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/createAssignment">Assignment</a>
                        </li> --%>
                        <li class="nav-item">
                          <% if (permissions.containsKey(featureMap.get("Admissions")) && 
           					permissions.get(featureMap.get("Admissions")).get("canRead")) { %>
                            	<a class="nav-link" href="${pageContext.request.contextPath}/admissionList">Admissions</a>
                       		<% } %>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">Settings</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">Log Out</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>        
</header>