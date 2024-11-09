<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create User</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<div class="container">
    <h2>User Registration Form</h2>
    
    <form action="userForm" method="post">
        <div class="form-group">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required class="form-control">
        </div>

        <div class="form-group">
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required class="form-control">
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required class="form-control">
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required class="form-control">
        </div>

        <div class="form-group">
            <label for="role">Role:</label>
            <select id="role" name="roleId" required class="form-control">
                <c:forEach var="role" items="${roles}">
                    <option value="${role.roleId}">${role.roleName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="department">Department:</label>
            <select id="department" name="departmentId" class="form-control">
                <c:forEach var="department" items="${departments}">
                    <option value="${department.departmentId}">${department.departmentName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="contactNumber">Contact Number:</label>
            <input type="text" id="contactNumber" name="contactNumber" class="form-control">
        </div>

        <div class="form-group">
            <label for="address">Address:</label>
            <textarea id="address" name="address" class="form-control"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Create User</button>
    </form>
</div>
</body>
</html>
