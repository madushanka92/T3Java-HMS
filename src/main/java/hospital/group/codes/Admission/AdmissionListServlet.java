package hospital.group.codes.Admission;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.AdmissionService;
import hospital.group.model.Admission;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdmissionListServlet
 */
@WebServlet("/admissionList")
public class AdmissionListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AdmissionService admissionService = new AdmissionService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdmissionListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		List<Admission> admissions = admissionService.getAllAdmissions();
        request.setAttribute("admissions", admissions);

        String contentPage = "views/admission/admission.jsp";

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
