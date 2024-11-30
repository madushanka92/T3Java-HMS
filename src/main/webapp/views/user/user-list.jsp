<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
	<c:if test="${not empty param.successMessage}">
	    <div class="alert alert-success" role="alert">
	        ${param.successMessage}
	    </div>
	</c:if>
	<c:if test="${not empty param.errorMessage}">
	    <div class="alert alert-danger" role="alert">
	        ${param.errorMessage}
	    </div>
	</c:if>
	
        <a href="create-user" class="btn btn-primary btn-lg">Add New User</a>
        <h1 class="text-center mb-4">User List</h1>

        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">User ID</th>
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Role</th>
                        <th scope="col">Department</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>${user.email}</td>
                            <td>${user.roleName}</td>
                            <td>${user.departmentName}</td>
                            <td>
                                 <c:if test="${user.roleName != 'Admin'}">
	                                <form action="delete-user" method="POST" onsubmit="return confirm('Are you sure you want to delete this user?');">
	                                    <input type="hidden" name="userId" value="${user.userId}">
	                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
	                                </form>
	                            </c:if>
	                            <c:if test="${user.roleName == 'Admin'}">
	                                <span class="text-muted">Cannot delete Admin</span>
	                            </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>