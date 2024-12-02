package hospital.group.codes.Department;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.UserService;
import hospital.group.dbservice.departmentService;
import hospital.group.model.Department;
import hospital.group.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/edit-department")
public class EditDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private departmentService departmentService = new departmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get department ID from request
        int departmentId = Integer.parseInt(request.getParameter("id"));
   	 UserService userService = new UserService();

        // Retrieve department and list of users
        Department department = departmentService.getDepartmentById(departmentId);
        List<User> userList = userService.getAllUsers(); // Adjust as per your actual method to fetch users

        // Set department and user list as attributes
        request.setAttribute("department", department);
        request.setAttribute("userList", userList);

        // Set the contentPage attribute to the correct JSP
        request.setAttribute("contentPage", "views/department/edit-department.jsp");

        // Forward to user_layout.jsp
        request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
    }
}
