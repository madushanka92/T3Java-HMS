<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/viewDepartment.css">

<div class="view-department">

<div class="container">
    <h2>Department List</h2>
    
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Department ID</th>
                <th>Department Name</th>
                <th>Head of Department ID</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="department" items="${departmentList}">
                <tr>
                    <td>${department.departmentId}</td>
                    <td>${department.departmentName}</td>
                    <td>${department.headOfDepartmentId}</td>
                    <td>
                        <!-- Edit Button -->
                        <a href="${pageContext.request.contextPath}/editDepartment?id=${department.departmentId}" 
                           class="btn btn-sm btn-primary">Edit</a>
                        
                        <!-- Delete Button with Confirmation -->
                        <a href="javascript:void(0);" 
                           class="btn btn-sm btn-danger" 
                           onclick="confirmDelete(${department.departmentId})">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<c:if test="${empty departmentList}">
    <p class="text-center">No departments found.</p>
</c:if>

<script type="text/javascript">
    function confirmDelete(departmentId) {
        // Show confirmation dialog
        const confirmation = confirm("Are you sure you want to delete this department?");
        if (confirmation) {
            // Redirect to deleteDepartment servlet if confirmed
            window.location.href = '${pageContext.request.contextPath}/deleteDepartment?id=' + departmentId;
        }
    }
</script>
</div>
