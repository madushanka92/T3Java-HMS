package hospital.group.codes;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewRoom")
public class viewRoomServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<roomJava> rooms = new ArrayList<>();

        try (Connection connection = new RoomService().getConnection()) {
            String query = "SELECT * FROM room";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                roomJava room = new roomJava(
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
            
            // Debugging: Print the fetched room data
            System.out.println("Rooms retrieved from the database: ");
            for (roomJava room : rooms) {
                System.out.println(room.getRoomId() + " | " + room.getRoomNumber());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set the rooms list as a request attribute
        request.setAttribute("rooms", rooms);

        // Set the contentPage attribute to the viewRoom.jsp for dynamic content
        request.setAttribute("contentPage", "views/viewRoom.jsp");

        // Forward the request to user_layout.jsp, where dynamic content will be rendered
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user_layout.jsp");
        dispatcher.forward(request, response);
    }
}
