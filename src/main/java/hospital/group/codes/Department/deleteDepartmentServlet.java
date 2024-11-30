package hospital.group.codes.Department;

import java.io.IOException;

import hospital.group.dbservice.departmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteDepartment")
public class deleteDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public deleteDepartmentServlet() {
        super();
    }

    /**
     * Handles the GET request to delete a department.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departmentIdStr = request.getParameter("id");

        if (departmentIdStr != null) {
            try {
                int departmentId = Integer.parseInt(departmentIdStr);

                // Create an instance of the service and delete the department
                departmentService service = new departmentService();
                boolean isDeleted = service.deleteDepartment(departmentId);

                // Check if the deletion was successful
                if (isDeleted) {
                    // Redirect to the department list page after deletion
                    response.sendRedirect("viewDepartment"); // Adjust the redirection path as needed
                } else {
                    // Handle failure to delete (e.g., department not found)
                    response.getWriter().write("Failed to delete department. Department may not exist.");
                }
            } catch (NumberFormatException e) {
                // Handle invalid departmentId format
                response.getWriter().write("Invalid department ID format.");
                e.printStackTrace();
            }
        } else {
            // Handle missing departmentId parameter
            response.getWriter().write("Department ID is missing.");
        }
    }
}
