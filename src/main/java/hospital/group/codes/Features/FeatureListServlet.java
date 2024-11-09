package hospital.group.codes.Features;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import hospital.group.dbservice.FeatureService;
import hospital.group.model.Feature;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FeatureListServlet
 */
@WebServlet("/features")
public class FeatureListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final FeatureService featureService = new FeatureService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public FeatureListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		List<Feature> featureList = featureService.getAllFeatures();
		request.setAttribute("features", featureList);
		String contentPage = "views/feature/features.jsp";

		request.setAttribute("contentPage", contentPage);

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
