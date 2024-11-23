<header>
   <nav class="navbar navbar-expand-lg navbar-light bg-body-tertiary header-container">
            <div class="container">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Assignment
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/createAssignment">New Record</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/listDoctorPatientAssignments">Doctor Patient</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/listNurseDoctorAssignments">Nurse Doctor</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/listTechnicianPatientAssignment">Technician Patient</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/listTechnicianDepartmentAssignments">Technician Department</a></li>
                            </ul>
                        </li>
                        <%-- <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/createAssignment">Assignment</a>
                        </li> --%>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admissionList">Admissions</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">Settings</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">Log Out</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>        
</header>