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
                            <a href="patient-list" class="nav-link ${pageContext.request.requestURI.endsWith('/patient-list') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Patients
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="createReport" class="nav-link ${pageContext.request.requestURI.endsWith('/recordForm') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Create Record
                            </a>
                        </li>
                        
                        <li class="nav-item">
                            <a href="viewReport" class="nav-link ${pageContext.request.requestURI.endsWith('/viewReport') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                View Record
                            </a>
                        </li>
                        
                        <li class="nav-item">
                            <a href="user-list" class="nav-link ${pageContext.request.requestURI.endsWith('/user-list') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Users
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
                        
                        
                        <li class="nav-item">
                            <a href="department-list" class="nav-link ${pageContext.request.requestURI.endsWith('/department-list') ? 'bg-selected' : ''}">
                                <i class="fa fa-cog me-2"></i>
                                Departments
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</nav>