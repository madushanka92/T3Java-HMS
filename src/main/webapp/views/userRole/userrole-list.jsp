<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="container">
        <h1>User Role List</h1>
        <a href="create-userrole" class="btn btn-primary">Add New Role</a>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Role ID</th>
                    <th>Role Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="userRole" items="${userRoleList}">
                    <tr>
                        <td>${userRole.roleId}</td>
                        <td>${userRole.roleName}</td>
                        <td>
                            <a href="edit-userrole?id=${userRole.roleId}" class="btn btn-sm btn-primary">Edit</a>
                            <a href="delete-userrole?id=${userRole.roleId}" class="btn btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
