<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<!-- jQuery (Bootstrap 4 and below) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
	
	<!-- Popper.js (required for dropdowns, tooltips, etc.) -->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" crossorigin="anonymous"></script>

	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Bootstrap JS and Popper.js -->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	
	
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
	
	  
	<meta charset="UTF-8">
	<link href="${pageContext.request.contextPath}/assets/css/components.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/css/main.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/css/views.css" rel="stylesheet">
	
	<title>User Logged In</title>
</head>
<body>

	<!-- Header -->
    <jsp:include page="shared/header.jsp" />

    <div class="page-content">
    	<!-- Navigation Menu -->
    	<jsp:include page="shared/menu.jsp" />	
    	
    	<!-- Page-Specific Content -->
	    <main>
	         <c:if test="${not empty contentPage}">
                <jsp:include page="${contentPage}" />
            </c:if>
	    </main>
    </div>

   

    <!-- Footer -->
    <jsp:include page="shared/footer.jsp" />
    
</body>
</html>