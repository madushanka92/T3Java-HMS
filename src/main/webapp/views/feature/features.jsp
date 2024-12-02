<%@ page import="java.util.List" %>
<%@ page import="hospital.group.model.Feature" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Feature> features = (List<Feature>) request.getAttribute("features");
%>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="text-center">Feature Management</h3>
        </div>
        <div class="card-body">
            <h4 class="text-center">Manage Features</h4>
            
            <!-- Feature List Table -->
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Feature Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feature" items="${features}">
                        <tr>
                            <td>${feature.featureName}</td>
                            <td>${feature.description}</td>
                            <td>${feature.isActive ? "Active" : "Inactive"}</td>
                            <td>
                                <!-- Edit Button -->
                                <form action="features/edit" method="get" class="d-inline">
                                    <input type="hidden" name="featureId" value="${feature.featureId}">
                                    <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                                </form>
                                
                                <!-- Toggle Active/Inactive Status -->
                                <form action="features/toggle" method="post" class="d-inline">
                                    <input type="hidden" name="featureId" value="${feature.featureId}">
                                    <input type="hidden" name="isActive" value="${!feature.isActive}">
                                    <button type="submit" class="btn btn-secondary btn-sm">
                                        ${feature.isActive ? "Deactivate" : "Activate"}
                                    </button>
                                </form>
                                
                                <!-- Delete Button -->
                                <form action="features/delete" method="post" class="d-inline">
                                    <input type="hidden" name="featureId" value="${feature.featureId}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Add New Feature Form -->
            <div class="mt-4">
                <h4>Add New Feature</h4>
                <form action="features/add" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="featureName">Feature Name:</label>
                                <input type="text" class="form-control" name="featureName" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea name="description" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" name="isActive" checked>
                                <label class="form-check-label" for="isActive">Active</label>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary">Add Feature</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
