<%@ page import="java.util.List" %>
<%@ page import="hospital.group.model.Feature" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Feature feature = (Feature) request.getAttribute("feature");
%>

<h2>Edit Feature</h2>

<form action="<c:url value='/features/edit' />" method="post">
    <input type="hidden" name="featureId" value="${feature.featureId}" />

    <label for="featureName">Feature Name:</label>
    <input type="text" id="featureName" name="featureName" value="${feature.featureName}" required />

    <label for="description">Description:</label>
    <textarea id="description" name="description">${feature.description}</textarea>

    <label for="isActive">Active:</label>
    <input type="checkbox" id="isActive" name="isActive" <c:if test="${feature.isActive}">checked</c:if> />

    <input type="submit" value="Save Changes" />
    <a href="features">Cancel</a>
</form>
