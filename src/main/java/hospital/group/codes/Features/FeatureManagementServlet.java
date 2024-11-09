package hospital.group.codes.Features;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import hospital.group.dbservice.FeatureMappingService;
import hospital.group.dbservice.FeatureService;
import hospital.group.dbservice.UserService;
import hospital.group.model.Feature;
import hospital.group.model.UserRole;

/**
 * Servlet implementation class FeatureManagementServlet
 */
@WebServlet("/featureMapping")
public class FeatureManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static FeatureService featureService = new FeatureService();
	private static UserService userService = new UserService();
	private static FeatureMappingService mappigService = new FeatureMappingService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FeatureManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//            List<Feature> featureList = featureService.getAllFeatures();
		//            request.setAttribute("features", featureList);
		    	    String contentPage = "views/featureMapping/featureMapping.jsp";
		
			        request.setAttribute("contentPage", contentPage);
		
		    	    request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		
		List<Feature> features = featureService.getAllFeatures();
        List<UserRole> roles = userService.getAllRoles();
        
        for (Feature feature : features) {
            for (UserRole role : roles) {
                boolean canCreate = request.getParameter("permissions_" + feature.getFeatureId() + "_" + role.getRoleId() + "_create") != null;
                boolean canRead = request.getParameter("permissions_" + feature.getFeatureId() + "_" + role.getRoleId() + "_read") != null;
                boolean canUpdate = request.getParameter("permissions_" + feature.getFeatureId() + "_" + role.getRoleId() + "_update") != null;
                boolean canDelete = request.getParameter("permissions_" + feature.getFeatureId() + "_" + role.getRoleId() + "_delete") != null;

                try {
                    // Use the combined update method to set all permissions
                	mappigService.updateFeaturePermissions(feature.getFeatureId(), role.getRoleId(), canCreate, canRead, canUpdate, canDelete);
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/features");
		
	}

}
