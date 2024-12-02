<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department List</title>
    <link rel="stylesheet" href="styles.css"> <!-- Add your CSS file -->
</head>
<body>
    <div class="container">
        <h1>Department List</h1>
        <a href="add-department.jsp" class="btn btn-primary">Add New Department</a>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Department ID</th>
                    <th>Department Name</th>
                    <th>Head of Department</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="department" items="${departmentList}">
                    <tr>
                        <td>${department.departmentId}</td>
                        <td>${department.departmentName}</td>
                        <td>${department.headOfDepartmentName}</td> <!-- Display the name -->
                        <td>
                            <a href="edit-department?id=${department.departmentId}" class="btn btn-sm btn-primary">Edit</a>
                            <a href="delete-department?id=${department.departmentId}" class="btn btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
