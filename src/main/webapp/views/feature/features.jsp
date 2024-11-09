<%@ page import="java.util.List" %>
<%@ page import="hospital.group.model.Feature" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Feature> features = (List<Feature>) request.getAttribute("features");
%>

<h2>Feature Management</h2>

<table border="1">
    <tr>
        <th>Feature Name</th>
        <th>Description</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="feature" items="${features}">
        <tr>
            <td>${feature.featureName}</td>
            <td>${feature.description}</td>
            <td>${feature.isActive ? "Active" : "Inactive"}</td>
            <td>
                <form action="features/edit" method="get">
                    <input type="hidden" name="featureId" value="${feature.featureId}">
                    <input type="submit" value="Edit">
                </form>
                <form action="features/toggle" method="post">
                    <input type="hidden" name="featureId" value="${feature.featureId}">
                    <input type="hidden" name="isActive" value="${!feature.isActive}">
                    <input type="submit" value="${feature.isActive ? "Deactivate" : "Activate"}">
                </form>
                <form action="features/delete" method="post">
                    <input type="hidden" name="featureId" value="${feature.featureId}">
                    <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<form action="features/add" method="post">
    <h3>Add New Feature</h3>
    <label for="featureName">Feature Name:</label>
    <input type="text" name="featureName" required>
    <label for="description">Description:</label>
    <textarea name="description"></textarea>
    <label for="isActive">Active:</label>
    <input type="checkbox" name="isActive" checked>
    <input type="submit" value="Add Feature">
</form>
