package hospital.group.codes.Users;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.UserService;
import hospital.group.model.Department;
import hospital.group.model.User;
import hospital.group.model.UserRole;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    // Fetch the user details and show the editable form (GET method)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("loggedInUser") != null) {
//            String userIdStr = (String) session.getAttribute("user");
//            Integer userId = Integer.parseInt(userIdStr);
            

    		User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

    		Integer userId = loggedInUser.getUserId();

            // Fetch the user details by userId
            User user = userService.getUserByUsername(userId);
            List<UserRole> roles = userService.getAllRoles();
            List<Department> departments = userService.getAllDepartments();

            if (user != null) {
                // Set the user object, roles, and departments as attributes to be used in JSP
                request.setAttribute("user", user);
                request.setAttribute("roles", roles);
                request.setAttribute("departments", departments);

                // Forward to user layout page with edit profile content
                request.setAttribute("contentPage", "views/user/editProfile.jsp");
                request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    // Handle the update when the form is submitted (POST method)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            String userIdStr = (String) session.getAttribute("user");
            Integer userId = Integer.parseInt(userIdStr);

            // Get the updated values from the form
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String contactNumber = request.getParameter("contactNumber");
            String address = request.getParameter("address");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            int departmentId = Integer.parseInt(request.getParameter("departmentId"));

            // Create a User object with the updated information
            User updatedUser = new User();
            updatedUser.setUserId(userId);
            updatedUser.setFirstName(firstName);
            updatedUser.setLastName(lastName);
            updatedUser.setEmail(email);
            updatedUser.setPassword(password);
            updatedUser.setContactNumber(contactNumber);
            updatedUser.setAddress(address);
            updatedUser.setRoleId(roleId);
            updatedUser.setDepartmentId(departmentId);

            // Update the user details in the database
            boolean isUpdated = userService.updateUser(updatedUser);

            if (isUpdated) {
                // If the update is successful, redirect to the profile page
                response.sendRedirect("profile");
            } else {
                // If the update failed, show an error message
                request.setAttribute("errorMessage", "Failed to update profile.");
                request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
