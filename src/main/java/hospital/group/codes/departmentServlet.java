package hospital.group.codes;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.dbservice.UserService;
import hospital.group.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addDepartment")
public class departmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 UserService userService = new UserService();
    	 List<User> userList = userService.getAllUsers(); // Modify to fetch only the necessary fields

    	request.setAttribute("userList", userList); // Set the list of users as a request attribute
		String action = request.getParameter("action");
		if ("success".equals(action)) {
			request.setAttribute("contentPage", "views/department/departmentSuccess.jsp");
        }else {
    		// Fetch roles and departments
            request.setAttribute("contentPage", "views/department/departmentCreationForm.jsp");
        }
		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);


	}
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departmentName = request.getParameter("departmentName");
        String headOfDepartmentId = request.getParameter("headOfDepartmentId");

        try (Connection connection = DatabaseConnection.connect()) {
            String sql = "INSERT INTO Department (departmentName, headOfDepartmentId) VALUES (?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, departmentName);
                statement.setString(2, headOfDepartmentId);
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                	 response.sendRedirect(request.getContextPath() + "/addDepartment?action=success");
                } else {
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("views/error.jsp");
        }
    }
}
