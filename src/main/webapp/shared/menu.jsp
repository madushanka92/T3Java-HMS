<nav>
   <div class="side-menu">
        <div class="d-flex">
            <div class="text-dark" style="width: 250px; height: 100vh;">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark flex-column">
                    <div class="navTitle">
                        <a class="navbar-brand" href="#">HMS</a>
                    </div>
                    <ul class="navbar-nav flex-column">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/home" class="nav-link ${pageContext.request.requestURI.endsWith('/home') ? 'bg-selected' : ''}">
                                <i class="fa fa-home me-2"></i>
                                Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/profile" class="nav-link ${pageContext.request.requestURI.endsWith('/profile') ? 'bg-selected' : ''}">
                                <i class="fa fa-user me-2"></i>
                                Profile
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="patientForm" class="nav-link ${pageContext.request.requestURI.endsWith('/patientForm') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Patient
                            </a>
                        </li>
                        
                        <li class="nav-item">
                            <a href="viewPatient" class="nav-link ${pageContext.request.requestURI.endsWith('/viewPatient') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                View Patient
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="userForm" class="nav-link ${pageContext.request.requestURI.endsWith('/userForm') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                User
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="features" class="nav-link ${pageContext.request.requestURI.endsWith('/features') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Features
                            </a>
                        </li>
                        
                        <li class="nav-item">
                            <a href="featureMapping" class="nav-link ${pageContext.request.requestURI.endsWith('/featureMapping') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Features Mapping
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</nav>