<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="text-center">Patient Registration Form</h3>
        </div>
        <div class="card-body">
            <form action="create-patient" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="firstName" class="form-label">First Name:</label>
                        <input type="text" id="firstName" name="firstName" required class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label for="lastName" class="form-label">Last Name:</label>
                        <input type="text" id="lastName" name="lastName" required class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label for="dateOfBirth" class="form-label">Date of Birth:</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" required class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label for="gender" class="form-label">Gender:</label>
                        <select id="gender" name="gender" required class="form-control">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="contactNumber" class="form-label">Contact Number:</label>
                        <input type="text" id="contactNumber" name="contactNumber" required class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" id="email" name="email" required class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label for="address" class="form-label">Address:</label>
                        <textarea id="address" name="address" required class="form-control"></textarea>
                    </div>
                    <div class="col-md-6">
                        <label for="emergencyContact" class="form-label">Emergency Contact:</label>
                        <input type="text" id="emergencyContact" name="emergencyContact" required class="form-control">
                    </div>

                    <div class="col-12">
                        <label for="medicalHistory" class="form-label">Medical History:</label>
                        <textarea id="medicalHistory" name="medicalHistory" required class="form-control"></textarea>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Register Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>