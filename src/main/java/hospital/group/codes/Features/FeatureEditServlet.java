package hospital.group.codes.Features;

import java.io.IOException;

import hospital.group.dbservice.FeatureService;
import hospital.group.model.Feature;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FeatureEditServlet
 */
@WebServlet("/features/edit")
public class FeatureEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final FeatureService featureService = new FeatureService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public FeatureEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int featureId = Integer.parseInt(request.getParameter("featureId"));

		Feature feature = featureService.findFeatureById(featureId);
        if (feature != null) {
            request.setAttribute("feature", feature);

    	    String contentPage = "views/feature/editFeature.jsp";

	        request.setAttribute("contentPage", contentPage);

    	    request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        } else {
            response.sendRedirect("features"); // Redirect if feature not found
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int featureId = Integer.parseInt(request.getParameter("featureId"));
        String featureName = request.getParameter("featureName");
        String description = request.getParameter("description");
        boolean isActive = request.getParameter("isActive") != null;

        Feature feature = new Feature(featureId, featureName, description, isActive, null, null);
        boolean isUpdated = featureService.updateFeature(feature);

        if (isUpdated) {
            response.sendRedirect(request.getContextPath() + "/features");
        } else {
            request.setAttribute("error", "Failed to update feature.");
            doGet(request, response); // Re-display the form with the error message
        }
	}

}
