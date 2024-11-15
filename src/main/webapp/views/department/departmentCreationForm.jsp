<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">

<div class="container">
    <h2>Department Creation Form</h2>
    
    <form action="addDepartment" method="post">
        <div class="form-group">
            <label for="departmentName">Department Name:</label>
            <input type="text" id="departmentName" name="departmentName" required class="form-control">
        </div>

        <div class="form-group">
    <label for="headOfDepartment">Head of Department:</label>
    <select id="headOfDepartment" name="headOfDepartment" required class="form-control">
        <c:forEach var="user" items="${userList}">
            <option value="${user.userId}">${user.userId} - ${user.firstName}</option>
        </c:forEach>
    </select>
</div>

        <button type="submit" class="btn btn-primary">Create Department</button>
    </form>
</div>
</body>
</html>
