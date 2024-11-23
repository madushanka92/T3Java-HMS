<%@ page import="java.util.List" %>
<%@ page import="hospital.group.model.Feature" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Feature feature = (Feature) request.getAttribute("feature");
%>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <h2 class="mb-4 text-center">Edit Feature</h2>
            <form action="<c:url value='/features/edit' />" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="featureId" value="${feature.featureId}" />

                <!-- Feature Name -->
                <div class="mb-3">
                    <label for="featureName" class="form-label">Feature Name</label>
                    <input 
                        type="text" 
                        id="featureName" 
                        name="featureName" 
                        class="form-control" 
                        value="${feature.featureName}" 
                        required 
                    />
                    <div class="invalid-feedback">
                        Please enter a feature name.
                    </div>
                </div>

                <!-- Description -->
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea 
                        id="description" 
                        name="description" 
                        class="form-control" 
                        rows="4"
                    >${feature.description}</textarea>
                </div>

                <!-- Active Checkbox -->
                <div class="form-check mb-3">
                    <input 
                        type="checkbox" 
                        id="isActive" 
                        name="isActive" 
                        class="form-check-input" 
                        <c:if test="${feature.isActive}">checked</c:if> 
                    />
                    <label for="isActive" class="form-check-label">Active</label>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/features" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>
