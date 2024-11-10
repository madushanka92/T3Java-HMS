<%@ page import="java.util.List" %>
<%@ page import="hospital.group.model.Feature" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Feature> features = (List<Feature>) request.getAttribute("features");
%>

<div class="feature-list">
	<h2>Feature Management</h2>
	
	<table border="1">
	    <tr>
	        <th>Feature Name</th>
	        <th>Description</th>
	        <th>Status</th>
	        <th>Actions</th>
	    </tr>
	    <c:forEach var="feature" items="${features}">
	        <tr>
	            <td>${feature.featureName}</td>
	            <td>${feature.description}</td>
	            <td>${feature.isActive ? "Active" : "Inactive"}</td>
	            <td>
	                <form action="features/edit" method="get">
	                    <input type="hidden" name="featureId" value="${feature.featureId}">
	                    <input type="submit" value="Edit">
	                </form>
	                <form action="features/toggle" method="post">
	                    <input type="hidden" name="featureId" value="${feature.featureId}">
	                    <input type="hidden" name="isActive" value="${!feature.isActive}">
	                    <input type="submit" value="${feature.isActive ? "Deactivate" : "Activate"}">
	                </form>
	                <form action="features/delete" method="post">
	                    <input type="hidden" name="featureId" value="${feature.featureId}">
	                    <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
	                </form>
	            </td>
	        </tr>
	    </c:forEach>
	</table>
	
	<div class="feature-new">
		<form action="features/add" method="post">
		   	<h3>Add New Feature</h3>
		    
		   	<div class="form-items">
		   		<div class="form-group">
		   			<label for="featureName">Feature Name:</label>
			    	<input type="text" class="form-control" name="featureName" required>
		   		</div>
		   		<div class="form-group">
				    <label for="description">Description:</label>
				    <textarea name="description" class="form-control"></textarea>
			    </div>
			    <div class="form-check">
				  <input class="form-check-input" type="checkbox" value="" name="isActive" checked>
				  <label class="form-check-label" for="isActive"> Active </label>
				</div>
				
			   <!--  <label for="isActive"></label>
			    <input type="checkbox" name="isActive" checked> -->
			    
		   	</div>
		   	
		   	
		    <div class="submit-btn">
		    	<input type="submit" value="Add Feature" class="btn btn-primary btn-block">
		    </div>
		</form>
		
		<%-- <div class="login-container">
				<div class="form-container">
					<form action="login" method="post">
						<div class="form-group">
							<label for="username">Username</label>
							<input type="text" class="form-control" id="username" name="username" required>
						</div>
						<div class="form-group">
							<label for="password">Password</label>
							<input type="password" class="form-control" id="password" name="password" required>
						</div>
						<button type="submit" class="btn btn-primary btn-block">Login</button>
					</form>
					
					<% if (request.getParameter("error") != null) { %>
					    <div class="error-message">
					    	<span>Invalid username or password. Please try again.</span>
					    </div>
					<% } %>
					
				</div>
			</div> --%>
	</div>
</div>
