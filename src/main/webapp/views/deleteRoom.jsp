<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <h2>Delete Room</h2>

    <form id="deleteForm" action="${pageContext.request.contextPath}/deleteRoom" method="post">
        <input type="hidden" name="roomId" value="${room.roomId}" />
        <p>Are you sure you want to delete Room ID: ${room.roomId}?</p>
        <button type="submit" class="btn btn-danger" onclick="return confirmDelete()">Yes, Delete</button>
        <a href="${pageContext.request.contextPath}/viewRoom" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this room? This action cannot be undone.");
    }
</script>
