package hospital.group.codes.Room;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Room;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class viewRoomServlet
 */
@WebServlet("/viewRoom")
public class viewRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewRoomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		List<Room> rooms = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();) {
            String query = "SELECT * FROM room";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Room room = new Room(
                    resultSet.getString("roomId"),
                    resultSet.getString("roomNumber"),
                    resultSet.getString("roomType"),
                    resultSet.getString("availabilityStatus"),
                    resultSet.getString("assignedPatientId"),
                    resultSet.getInt("floorNumber"),
                    resultSet.getString("departmentId"),
                    resultSet.getString("lastCleanedAt"),
                    resultSet.getDouble("dailyRate")
                );
                rooms.add(room);

            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set the rooms list as a request attribute
        request.setAttribute("rooms", rooms);

        // Set the contentPage attribute to the viewRoom.jsp for dynamic content
        request.setAttribute("contentPage", "views/room/viewRoom.jsp");

        // Forward the request to user_layout.jsp, where dynamic content will be rendered
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user_layout.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
