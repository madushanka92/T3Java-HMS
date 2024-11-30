package hospital.group.codes;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteRoom")
public class deleteRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomId = request.getParameter("roomId");

        if (roomId == null || roomId.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid room ID.");
            request.setAttribute("contentPage", "views/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            return;
        }

        roomejava room = roomService.getRoomById(roomId);
        if (room != null) {
            request.setAttribute("room", room);
            request.setAttribute("contentPage", "views/deleteRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Room not found.");
            request.setAttribute("contentPage", "views/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomId = request.getParameter("roomId");

        if (roomId == null || roomId.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid room ID provided.");
            request.setAttribute("contentPage", "views/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            return;
        }

        boolean isDeleted = roomService.deleteRoom(roomId);
        if (isDeleted) {
            response.sendRedirect(request.getContextPath() + "/viewRoom");
        } else {
            request.setAttribute("errorMessage", "Failed to delete room.");
            request.setAttribute("contentPage", "views/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        }
    }
}
