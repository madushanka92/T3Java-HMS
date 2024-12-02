<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white text-center">
            <h3>Create New Department</h3>
        </div>
        <div class="card-body">
            <form action="create-department" method="post">
                
                <!-- Department Name -->
                <div class="mb-3">
                    <label for="departmentName" class="form-label">Department Name:</label>
                    <input type="text" id="departmentName" name="departmentName" required class="form-control" placeholder="Enter department name">
                    <div class="invalid-feedback">
                        Please enter a department name.
                    </div>
                </div>

                <!-- Head of Department -->
                <div class="mb-3">
                    <label for="headOfDepartment" class="form-label">Head of Department:</label>
                    <select id="headOfDepartment" name="headOfDepartment" required class="form-control">
                        <c:forEach var="user" items="${userList}">
                            <option value="${user.userId}">${user.userId} - ${user.firstName}</option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">
                        Please select the head of the department.
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="d-flex justify-content-center mt-4">
                    <button type="submit" class="btn btn-success btn-lg">Create Department</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Bootstrap form validation
    (function () {
        'use strict'
        window.addEventListener('load', function () {
            var forms = document.getElementsByClassName('needs-validation')
            Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        }, false)
    })();
</script>
</body>
</html>
