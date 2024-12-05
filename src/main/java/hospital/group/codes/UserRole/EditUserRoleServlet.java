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
 * Servlet implementation class EditUserRoleServlet
 */
@WebServlet("/edit-userrole")
public class EditUserRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditUserRoleServlet() {
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

		int roleId = Integer.parseInt(request.getParameter("id"));
        UserRoleService userRoleService = new UserRoleService();

        UserRole userRole = userRoleService.getUserRoleById(roleId);
        request.setAttribute("userRole", userRole);
        request.setAttribute("contentPage", "views/userRole/edit-userrole.jsp");
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
