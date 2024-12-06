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
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="text-center">User Registration Form</h3>
        </div>
        <div class="card-body">
            <c:if test="${not empty message}">
                <p style="color: red;" class="text-center">${message}</p>
            </c:if>

            <form action="create-user" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="firstName" class="form-label">First Name:</label>
                        <input type="text" id="firstName" name="firstName" required class="form-control" 
                               value="${formData != null ? formData.firstName : ''}">
                    </div>

                    <div class="col-md-6">
                        <label for="lastName" class="form-label">Last Name:</label>
                        <input type="text" id="lastName" name="lastName" required class="form-control" 
                               value="${formData != null ? formData.lastName : ''}">
                    </div>

                    <div class="col-md-6">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" id="email" name="email" required class="form-control" 
                               value="${formData != null ? formData.email : ''}">
                    </div>

                    <div class="col-md-6">
                        <label for="password" class="form-label">Password:</label>
                        <input type="password" id="password" name="password" required class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label for="role" class="form-label">Role:</label>
                        <select id="role" name="roleId" required class="form-control">
                            <c:forEach var="role" items="${roles}">
                                <option value="${role.roleId}" 
                                        ${formData != null && formData.roleId == role.roleId ? 'selected' : ''}>
                                    ${role.roleName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="department" class="form-label">Department:</label>
                        <select id="department" name="departmentId" class="form-control">
                            <option value="0">None</option> <!-- Allow "None" as an option -->
                            <c:forEach var="department" items="${departments}">
                                <option value="${department.departmentId}" 
                                        ${formData != null && formData.departmentId == department.departmentId ? 'selected' : ''}>
                                    ${department.departmentName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="contactNumber" class="form-label">Contact Number:</label>
                        <input type="text" id="contactNumber" name="contactNumber" class="form-control" 
                               value="${formData != null ? formData.contactNumber : ''}">
                    </div>

                    <div class="col-12">
                        <label for="address" class="form-label">Address:</label>
                        <textarea id="address" name="address" class="form-control">${formData != null ? formData.address : ''}</textarea>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Create User</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
