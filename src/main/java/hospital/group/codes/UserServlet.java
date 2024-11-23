package hospital.group.codes;

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

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/userForm")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private final UserService userService = new UserService();


    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		if ("success".equals(action)) {
			request.setAttribute("contentPage", "views/user/userSuccess.jsp");
        }else {

        	if ("error".equals(action)) {

        		HttpSession session = request.getSession();

                // Retrieve and set error message and form data
                String message = (String) session.getAttribute("errorMessage");
                User formData = (User) session.getAttribute("formData");

                request.setAttribute("message", message);
                request.setAttribute("formData", formData);

                // Remove attributes from session
                session.removeAttribute("errorMessage");
                session.removeAttribute("formData");
            }

    		// Fetch roles and departments
            List<UserRole> roles = userService.getAllRoles();
            List<Department> departments = userService.getAllDepartments();


            // Set attributes for the JSP
            request.setAttribute("roles", roles);
            request.setAttribute("departments", departments);

            request.setAttribute("contentPage", "views/user/userCreateForm.jsp");
        }
		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		// Extract form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));

        User newUser = new User(0 , firstName, lastName, email, password, roleId, contactNumber, address, departmentId);
        String isSaved = userService.createUser(newUser);

        // Check if save was successful and redirect accordingly
        if (isSaved.equals("User created successfully!")) {
            response.sendRedirect(request.getContextPath() + "/userForm?action=success"); // Redirect to success page
        } else {

        	HttpSession session = request.getSession();
            session.setAttribute("errorMessage", isSaved);
            session.setAttribute("formData", newUser);

            response.sendRedirect(request.getContextPath() + "/userForm?action=error");

        }
	}

}
