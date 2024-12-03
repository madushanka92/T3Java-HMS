<%@page import="java.util.Map"%>
<%@page import="hospital.group.dbservice.FeatureService"%>
<%@page import="hospital.group.dbservice.FeatureMappingService"%>
<%@ page import="hospital.group.model.User" %>
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


<nav>
   <div class="side-menu">
        <div class="d-flex">
            <div class="text-dark" style="width: 250px; height: 100vh;">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark flex-column">
                    <div class="navTitle">
                        <a class="navbar-brand" href="#">HMS</a>
                    </div>
                    <ul class="navbar-nav flex-column">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/home" class="nav-link ${pageContext.request.requestURI.endsWith('/home') ? 'bg-selected' : ''}">
                                <i class="fa fa-hospital-symbol me-2"></i>
                                Home
                            </a>
                        </li> 
                        
                                             
                        
                        <li class="nav-item">
						    <% if (permissions.containsKey(featureMap.get("UserProfile")) && 
						           permissions.get(featureMap.get("UserProfile")).get("canRead")) { %>
						        <a href="${pageContext.request.contextPath}/profile" class="nav-link ${pageContext.request.requestURI.endsWith('/profile') ? 'bg-selected' : ''}">
						            <i class="fa fa-user me-2"></i>
						            Profile
						        </a>
						    <% } %>
						</li> 
                        
                        <li class="nav-item">
						    <% if (permissions.containsKey(featureMap.get("Patient")) && 
						           permissions.get(featureMap.get("Patient")).get("canRead")) { %>
						        <a href="${pageContext.request.contextPath}/patient-list" class="nav-link ${pageContext.request.requestURI.endsWith('/patient-list') ? 'bg-selected' : ''}">
						            <i class="fa fa-procedures me-2"></i>
						            Patients
						        </a>
						    <% } %>
						</li> 
						
                        <li class="nav-item">
                            <a href="createReport" class="nav-link ${pageContext.request.requestURI.endsWith('/recordForm') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Create Record
                            </a>
                        </li>
                        
                        <li class="nav-item">
                            <a href="viewReport" class="nav-link ${pageContext.request.requestURI.endsWith('/viewReport') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                View Record
                            </a>
                        </li>                       
                        
                        <li class="nav-item">
						    <% if (permissions.containsKey(featureMap.get("User")) && 
						           permissions.get(featureMap.get("User")).get("canRead")) { %>
						        <a href="${pageContext.request.contextPath}/user-list" class="nav-link ${pageContext.request.requestURI.endsWith('/user-list') ? 'bg-selected' : ''}">
						            <i class="fa fa-users me-2"></i>
						            Users
						        </a>
						    <% } %>
						</li>
						
						                
                        
                        <li class="nav-item">
						    <% if (permissions.containsKey(featureMap.get("Feature")) && 
						           permissions.get(featureMap.get("Feature")).get("canRead")) { %>
						        <a href="${pageContext.request.contextPath}/features" class="nav-link ${pageContext.request.requestURI.endsWith('/features') ? 'bg-selected' : ''}">
						            <i class="fa fa-hospital me-2"></i>
						            Features
						        </a>
						    <% } %>
						</li>   
						
                        <li class="nav-item">
						    <% if (permissions.containsKey(featureMap.get("Feature")) && 
						           permissions.get(featureMap.get("Feature")).get("canRead")) { %>
						        <a href="${pageContext.request.contextPath}/featureMapping" class="nav-link ${pageContext.request.requestURI.endsWith('/featureMapping') ? 'bg-selected' : ''}">
						            <i class="fa fa-hospital-user me-2"></i>
						            Features Mapping
						        </a>
						    <% } %>
						</li>  
						
						
                        <li class="nav-item">

                            
      
						    <% if (permissions.containsKey(featureMap.get("Department")) && 
						           permissions.get(featureMap.get("Department")).get("canRead")) { %>
						        <a href="${pageContext.request.contextPath}/department-list" class="nav-link ${pageContext.request.requestURI.endsWith('/department-list') ? 'bg-selected' : ''}">
						            <i class="fa fa-city me-2"></i>
						            Departments
						        </a>
						    <% } %>
						</li>  


                        
                        <li class="nav-item">
    						<a href="${pageContext.request.contextPath}/paymentForm" class="nav-link ${pageContext.request.requestURI.endsWith('/addPayment') ? 'bg-selected' : ''}">
        						<i class="fa fa-credit-card me-2"></i>
        						Add Payment
    						</a>
						</li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</nav>