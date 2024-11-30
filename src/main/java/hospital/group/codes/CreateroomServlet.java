package hospital.group.codes;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// Servlet mapped to "/createRoom"
@WebServlet("/createRoom")
public class CreateroomServlet extends HttpServlet {

    // Handles GET request: Load the form page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the contentPage attribute to the createRoom.jsp
        request.setAttribute("contentPage", "views/createRoom.jsp");
        
        // Forward the request to user_layout.jsp, where dynamic content will be rendered
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user_layout.jsp");
        dispatcher.forward(request, response);
    }

    // Handles POST request: Process form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form data
            String roomNumber = request.getParameter("roomNumber");
            String roomType = request.getParameter("roomType");
            String availabilityStatus = request.getParameter("availabilityStatus");
            String assignedPatientId = request.getParameter("assignedPatientId");
            String floorNumber = request.getParameter("floorNumber");
            String departmentId = request.getParameter("departmentId");
            String lastCleanedAt = request.getParameter("lastCleanedAt");
            String dailyRate = request.getParameter("dailyRate");

            // Log the received data for debugging
            System.out.println("Received Room Data: " + roomNumber + ", " + roomType + ", " + availabilityStatus);

            // Validate the input
            if (roomNumber == null || roomNumber.trim().isEmpty() ||
                roomType == null || roomType.trim().isEmpty() ||
                availabilityStatus == null || availabilityStatus.trim().isEmpty() ||
                floorNumber == null || floorNumber.trim().isEmpty() ||
                departmentId == null || departmentId.trim().isEmpty() ||
                dailyRate == null || dailyRate.trim().isEmpty()) {
                
                throw new IllegalArgumentException("All fields except assignedPatientId and lastCleanedAt are mandatory.");
            }

            // Convert and process input
            int parsedFloorNumber = Integer.parseInt(floorNumber); // Floor number must be an integer
            double parsedDailyRate = Double.parseDouble(dailyRate); // Daily rate must be a double

            // Save the data to the database using the Service layer
            RoomService roomService = new RoomService();
            boolean isSaved = roomService.saveRoom(
                roomNumber, roomType, availabilityStatus, assignedPatientId,
                parsedFloorNumber, departmentId, lastCleanedAt, parsedDailyRate
            );

            // Redirect to the List Rooms page after successful saving
            if (isSaved) {
                response.sendRedirect("viewRoom"); // Redirect to "viewRoom" if save is successful
            } else {
                request.setAttribute("errorMessage", "Failed to create room. Please try again.");
                request.getRequestDispatcher("views/error.jsp").forward(request, response); // Show the form again on failure
            }
        } catch (NumberFormatException e) {
            // Handle number format exceptions
            request.setAttribute("errorMessage", "Invalid number format for floor or daily rate.");
            request.getRequestDispatcher("views/createRoom.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            // Handle invalid input
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("views/createRoom.jsp").forward(request, response);
        } catch (Exception e) {
            // Handle generic exceptions
            e.printStackTrace(); // Log the exception for debugging
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("views/createRoom.jsp").forward(request, response);
        }
    }
}
