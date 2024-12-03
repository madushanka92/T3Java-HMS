package hospital.group.codes.Department;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import hospital.group.db.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateDepartment")
public class updateDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        String departmentName = request.getParameter("departmentName");
        int headOfDepartmentId = Integer.parseInt(request.getParameter("headOfDepartment"));

        try (Connection connection = DatabaseConnection.connect()) {
            String sql = "UPDATE Department SET departmentName = ?, headOfDepartmentId = ? WHERE departmentId = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, departmentName);
                statement.setInt(2, headOfDepartmentId);
                statement.setInt(3, departmentId);

                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    // Redirect to department list if update is successful
                    response.sendRedirect(request.getContextPath() + "/department-list");
                } else {
                    // Redirect to an error page if the update fails
                    response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }
    }
}
