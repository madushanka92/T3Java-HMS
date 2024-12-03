<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-4">
    <h1 class="mb-4">Technician-Department Assignments</h1>

    <!-- Check if there are any assignments to display -->
    <c:if test="${not empty assignments}">
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Assignment ID</th>
                    <th scope="col">Technician</th>
                    <th scope="col">Department</th>
                    <th scope="col">Assigned Date</th>
                    <th scope="col">Status</th>
                    <th scope="col">Work Shift</th>
                    <th scope="col">Start Date</th>
                    <th scope="col">End Date</th>
                    <th scope="col">Notes</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="assignment" items="${assignments}">
                    <tr>
                        <td>${assignment.assignmentId}</td>
                        <td>${assignment.technicianFirstName} ${assignment.technicianLastName}</td>
                        <td>${assignment.departmentName}</td>
                        <td>${assignment.assignedDate}</td>
                        <td>${assignment.status}</td>
                        <td>${assignment.workShift}</td>
                        <td>${assignment.startDate}</td>
                        <td>${assignment.endDate}</td>
                        <td>${assignment.notes}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Message for no assignments -->
    <c:if test="${empty assignments}">
        <div class="alert alert-warning" role="alert">
            No assignments found.
        </div>
    </c:if>
</div>
