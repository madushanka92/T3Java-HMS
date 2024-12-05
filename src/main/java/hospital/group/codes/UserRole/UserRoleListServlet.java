package hospital.group.codes.UserRole;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.UserRoleService;
import hospital.group.model.UserRole;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserRoleListServlet
 */
@WebServlet("/userrole-list")
public class UserRoleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRoleListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());

		UserRoleService userRoleService = new UserRoleService();

        // Fetch the list of user roles from the database
        List<UserRole> userRoleList = userRoleService.getAllUserRoles();

        // Add the list to the request scope
        request.setAttribute("userRoleList", userRoleList);

        // Forward the request to the JSP
        request.setAttribute("contentPage", "views/userRole/userrole-list.jsp");
		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);

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
