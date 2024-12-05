package hospital.group.codes.UserRole;

import java.io.IOException;

import hospital.group.dbservice.UserRoleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteUserRoleServlet
 */
@WebServlet("/delete-userrole")
public class DeleteUserRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserRoleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int roleId = Integer.parseInt(request.getParameter("id"));
        UserRoleService userRoleService = new UserRoleService();

        if (userRoleService.deleteUserRole(roleId)) {
            request.setAttribute("contentPage", "views/userRole/userrole-list.jsp");
        } else {
            request.setAttribute("contentPage", "views/error.jsp");
        }
//		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
		response.sendRedirect("userrole-list");
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
