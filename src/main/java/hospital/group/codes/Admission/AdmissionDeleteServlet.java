package hospital.group.codes.Admission;

import java.io.IOException;

import hospital.group.dbservice.AdmissionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdmissionDeleteServlet
 */
@WebServlet("/admissionDelete")
public class AdmissionDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static AdmissionService admissionService = new AdmissionService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdmissionDeleteServlet() {
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

		String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int admissionId = Integer.parseInt(idParam);
                boolean isDeleted = admissionService.deleteAdmission(admissionId);

                if (isDeleted) {
                    // Redirect to the admission list with success message
                    request.getSession().setAttribute("message", "Admission deleted successfully!");
                } else {
                    // Redirect with an error message
                    request.getSession().setAttribute("error", "Failed to delete the admission.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid admission ID.");
            }
        } else {
            request.getSession().setAttribute("error", "No admission ID provided.");
        }

        response.sendRedirect("admissionList");
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
