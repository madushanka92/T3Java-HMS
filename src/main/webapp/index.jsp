
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Group 7</title>
		<link href="${pageContext.request.contextPath}/assets/css/login.css" rel="stylesheet" type="text/css">
		<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">


		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	</head>

	<body class="login-page">
		<link rel="stylesheet" href="./assets/css/login.css">Ï
		<div class="login-main">
			<div class="title">
				<h2 class="text-center mt-5">Hospital Management System Login</h2>
			</div>
			<div class="login-container">
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
				</div>
			</div>

		</div>
		
		

	</body>

	</html>