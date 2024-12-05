<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <h2>Edit User Role</h2>
    <form action="${pageContext.request.contextPath}/updateUserRole" method="POST">
        <!-- Role ID (Hidden) -->
        <input type="hidden" name="roleId" value="${userRole.roleId}">

        <div class="form-group">
            <label for="roleName">Role Name</label>
            <input type="text" id="roleName" name="roleName" class="form-control" 
                   value="${userRole.roleName}" required>
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="${pageContext.request.contextPath}/userrole-list" class="btn btn-secondary">Cancel</a>
    </form>
</div>
