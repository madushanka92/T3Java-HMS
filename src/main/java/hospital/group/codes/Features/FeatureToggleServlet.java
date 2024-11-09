package hospital.group.codes.Features;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import hospital.group.dbservice.FeatureService;
import hospital.group.model.Feature;

/**
 * Servlet implementation class FeatureToggleServlet
 */
@WebServlet("/features/toggle")
public class FeatureToggleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final FeatureService featureService = new FeatureService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FeatureToggleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		int featureId = Integer.parseInt(request.getParameter("featureId"));
		String isActiveParam = request.getParameter("isActive");
		boolean newStatus = (isActiveParam != null && isActiveParam.equalsIgnoreCase("true"));
         
        boolean isUpdated = false;
		try {
			isUpdated = featureService.toggleFeatureStatus(featureId, newStatus);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (isUpdated) {
            response.sendRedirect(request.getContextPath() + "/features");
        } else {
            request.setAttribute("error", "Failed to update feature.");
            doGet(request, response); // Re-display the form with the error message
        }
	}

}
