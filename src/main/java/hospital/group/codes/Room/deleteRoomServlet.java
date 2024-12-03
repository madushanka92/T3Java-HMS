package hospital.group.codes.Room;

import java.io.IOException;

import hospital.group.dbservice.RoomService;
import hospital.group.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class deleteRoomServlet
 */
@WebServlet("/deleteRoom")
public class deleteRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private final RoomService roomService = new RoomService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteRoomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String roomId = request.getParameter("roomId");

        if (roomId == null || roomId.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid room ID.");
            request.setAttribute("contentPage", "views/room/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            return;
        }

        Room room = RoomService.getRoomById(roomId);
        if (room != null) {
            request.setAttribute("room", room);
            request.setAttribute("contentPage", "views/room/deleteRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Room not found.");
            request.setAttribute("contentPage", "views/room/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String roomId = request.getParameter("roomId");

        if (roomId == null || roomId.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid room ID provided.");
            request.setAttribute("contentPage", "views/room/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            return;
        }

        boolean isDeleted = roomService.deleteRoom(roomId);
        if (isDeleted) {
            response.sendRedirect(request.getContextPath() + "/viewRoom");
        } else {
            request.setAttribute("errorMessage", "Failed to delete room.");
            request.setAttribute("contentPage", "views/room/viewRoom.jsp");
            request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        }
	}

}
