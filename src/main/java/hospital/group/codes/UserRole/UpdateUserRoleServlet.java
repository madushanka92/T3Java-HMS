package hospital.group.codes.UserRole;

import java.io.IOException;

import hospital.group.dbservice.UserRoleService;
import hospital.group.model.UserRole;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateUserRoleServlet
 */
@WebServlet("/updateUserRole")
public class UpdateUserRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserRoleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		// Retrieve form parameters
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String roleName = request.getParameter("roleName");

        // Create a UserRole object with the updated information
        UserRole userRole = new UserRole();
        userRole.setRoleId(roleId);
        userRole.setRoleName(roleName);

        // Call the service to update the role in the database
        UserRoleService userRoleService = new UserRoleService();
        boolean isUpdated = userRoleService.updateUserRole(userRole);

        if (isUpdated) {
            // Redirect to the roles list if update is successful
            request.setAttribute("contentPage", "views/userRole/userrole-list.jsp");
        } else {
            // Redirect to an error page or re-display the form with an error message
            request.setAttribute("errorMessage", "Failed to update the role.");
            request.setAttribute("contentPage", "views/userRole/edit-userrole.jsp");
        }
//		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
		response.sendRedirect("userrole-list");
	}

}
