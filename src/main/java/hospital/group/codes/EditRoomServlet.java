package hospital.group.codes;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editRoom")
public class EditRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Parse roomId from the request parameter
            String roomId = request.getParameter("roomId");
            if (roomId == null || roomId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/viewRoom");
                return;
            }

            // Fetch room details from the database
            roomejava room = roomService.getRoomById(roomId);

            if (room != null) {
                // Room exists, forward it to the edit page
                request.setAttribute("room", room);
                request.setAttribute("contentPage", "views/editRoom.jsp");
                request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            } else {
                // Room not found, redirect to viewRoom
                response.sendRedirect(request.getContextPath() + "/viewRoom");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle unexpected exceptions and redirect to the viewRoom page
            response.sendRedirect(request.getContextPath() + "/viewRoom");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Collect updated room details from the form
            String roomId = request.getParameter("roomId");
            String roomNumber = request.getParameter("roomNumber");
            String roomType = request.getParameter("roomType");
            String availabilityStatus = request.getParameter("availabilityStatus");
            String assignedPatientId = request.getParameter("assignedPatientId"); // May be empty
            int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
            String departmentId = request.getParameter("departmentId");
            String lastCleanedAt = request.getParameter("lastCleanedAt");
            double dailyRate = Double.parseDouble(request.getParameter("dailyRate"));

            // Debugging: Ensure the form data is received correctly
            System.out.println("Room ID: " + roomId);
            System.out.println("Room Number: " + roomNumber);
            System.out.println("Room Type: " + roomType);
            System.out.println("Availability Status: " + availabilityStatus);
            System.out.println("Assigned Patient ID: " + assignedPatientId);
            System.out.println("Floor Number: " + floorNumber);
            System.out.println("Department ID: " + departmentId);
            System.out.println("Last Cleaned At: " + lastCleanedAt);
            System.out.println("Daily Rate: " + dailyRate);

            // Call the update method in RoomService
            boolean isUpdated = roomService.updateRoom(roomId, roomNumber, roomType, availabilityStatus, 
                                                      assignedPatientId, floorNumber, departmentId, 
                                                      lastCleanedAt, dailyRate);

            if (isUpdated) {
                // Update successful, redirect to the viewRoom page
                response.sendRedirect(request.getContextPath() + "/viewRoom");
            } else {
                // Update failed, stay on the edit page and show an error
                request.setAttribute("errorMessage", "Update failed. Please try again.");
                request.setAttribute("room", new roomejava(roomId, roomNumber, roomType, availabilityStatus,
                        assignedPatientId, floorNumber, departmentId, lastCleanedAt, dailyRate));
                request.setAttribute("contentPage", "views/editRoom.jsp");
                request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions gracefully and redirect to viewRoom
            response.sendRedirect(request.getContextPath() + "/viewRoom");
        }
    }
}
