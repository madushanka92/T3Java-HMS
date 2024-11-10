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