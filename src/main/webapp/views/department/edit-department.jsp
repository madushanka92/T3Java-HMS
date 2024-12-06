<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/editPatient.css">

<div class="container">
    <h2>Edit Department</h2>

    <form action="${pageContext.request.contextPath}/updateDepartment" method="POST">
        <!-- Department ID (Hidden) -->
        <input type="hidden" name="departmentId" value="${department.departmentId}">

        <div class="form-group">
            <label for="departmentName">Department Name</label>
            <input type="text" id="departmentName" name="departmentName" class="form-control" 
                   value="${department.departmentName}" required>
        </div>

        <div class="form-group">
            <label for="headOfDepartment">Head of Department</label>
            <select id="headOfDepartment" name="headOfDepartment" class="form-control" required>
                <c:forEach var="user" items="${userList}">
                    <option value="${user.userId}" 
                            <c:if test="${user.userId == department.headOfDepartmentId}">selected</c:if>>
                        ${user.firstName} ${user.lastName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="${pageContext.request.contextPath}/department-list" class="btn btn-secondary">Cancel</a>
    </form>
</div>
