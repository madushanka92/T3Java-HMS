package hospital.group.codes.Features;

import java.io.IOException;
import java.sql.SQLException;

import hospital.group.dbservice.FeatureService;
import hospital.group.model.Feature;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FeatureAddServlet
 */
@WebServlet("/features/add")
public class FeatureAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final FeatureService featureService = new FeatureService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public FeatureAddServlet() {
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
		String name = request.getParameter("featureName");
        String description = request.getParameter("description");
        boolean isActive = request.getParameter("isActive") != null;

        Feature feature = new Feature(0, name, description, isActive, null, null);
        try {
        	featureService.addFeature(feature);
            response.sendRedirect(request.getContextPath() + "/features");
        } catch (SQLException e) {
            throw new ServletException("Error adding feature", e);
        }
	}

}
