<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Logged In</title>
</head>
<body>

	<!-- Header -->
    <jsp:include page="shared/header.jsp" />

    <!-- Navigation Menu -->
    <jsp:include page="shared/menu.jsp" />

    <!-- Page-Specific Content -->
    <main>
        <% String contentPage = (String) request.getAttribute("contentPage"); %>
		<jsp:include page="<%= contentPage %>" />
    </main>

    <!-- Footer -->
    <jsp:include page="shared/footer.jsp" />
</body>
</html>