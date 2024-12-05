<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white text-center">
            <h3>Create New User Role</h3>
        </div>
        <div class="card-body">
            <form action="create-userrole" method="post">
                <!-- Role Name -->
                <div class="mb-3">
                    <label for="roleName" class="form-label">Role Name:</label>
                    <input type="text" id="roleName" name="roleName" required class="form-control" placeholder="Enter role name">
                    <div class="invalid-feedback">
                        Please enter a role name.
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="d-flex justify-content-center mt-4">
                    <button type="submit" class="btn btn-success btn-lg">Create Role</button>
                </div>
            </form>
        </div>
    </div>
</div>
