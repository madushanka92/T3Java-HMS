<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<div class="container">
    <h2>Edit Profile</h2>

    <form action="editProfile" method="post">
        <div class="form-group">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="${user.firstName}" required class="form-control">
        </div>

        <div class="form-group">
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="${user.lastName}" required class="form-control">
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${user.email}" required class="form-control">
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="${user.password}" required class="form-control">
        </div>

        <div class="form-group">
            <label for="role">Role:</label>
            <input type="text" id="role" name="role" value="${user.roleName}" class="form-control" disabled>
            <input type="hidden" name="roleId" value="${user.roleId}"> 
        </div>

       <div class="form-group">
            <label for="department">Department:</label>
            <input type="text" id="department" name="department" value="${user.departmentName}" class="form-control" disabled>
            <input type="hidden" name="departmentId" value="${user.departmentId}"> 
        </div>

        <div class="form-group">
            <label for="contactNumber">Contact Number:</label>
            <input type="text" id="contactNumber" name="contactNumber" value="${user.contactNumber}" class="form-control">
        </div>

        <div class="form-group">
            <label for="address">Address:</label>
            <textarea id="address" name="address" class="form-control">${user.address}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Profile</button>
    </form>
</div>
</body>
</html>
