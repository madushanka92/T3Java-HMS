<div class="container py-5">
    <div class="row justify-content-center">
        <!-- Left Section: Avatar and Greeting -->
        <div class="col-md-4 d-flex flex-column align-items-center mb-4" style="justify-content: space-evenly;">
            
            <img src="assets/imgs/AVATAR.png" alt="User Avatar" class="avatar img-fluid rounded-circle border" style="width: 150px; height: 150px; object-fit: cover;">
            <h2>Hello, ${user.firstName} ${user.lastName}</h2>
        </div>

        <!-- Right Section: User Information -->
        <div class="col-md-6">
            <div class="card p-4">
                <h3 class="card-title mb-4">User Information</h3>
                <div class="user-info mb-4">
                    <p><strong>First Name:</strong> ${user.firstName}</p>
                    <p><strong>Last Name:</strong> ${user.lastName}</p>
                    <p><strong>Email:</strong> ${user.email}</p>
                    <p><strong>ROLE:</strong> ${user.roleName}</p>
                    <p><strong>Department:</strong> ${user.departmentName}</p>
                    <p><strong>Address:</strong> ${user.address}</p>
                    <p><strong>Contact Number:</strong> ${user.contactNumber}</p>
                </div>
                <a href="editProfile" class="btn btn-primary w-100">Edit Profile</a>
            </div>
        </div>
    </div>
</div>
