package hospital.group.codes.Users;

import java.io.IOException;

import hospital.group.dbservice.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
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
		int userId = Integer.parseInt(request.getParameter("userId"));

        UserService userService = new UserService();
        try {
            boolean isDeleted = userService.deleteUser(userId);

            if (isDeleted) {
                response.sendRedirect(request.getContextPath() + "/user-list?successMessage=User+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/user-list?errorMessage=Failed+to+delete+user");
            }

        } catch (RuntimeException e) {
            // Handle specific foreign key violation
            response.sendRedirect(request.getContextPath() + "/user-list?errorMessage="
                    + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
	}

}
