package hospital.group.codes.Assignment;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.AssignmentService;
import hospital.group.model.DoctorPatientAssignment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DoctorPatientAssignmentListServlet
 */
@WebServlet("/listDoctorPatientAssignments")
public class DoctorPatientAssignmentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoctorPatientAssignmentListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AssignmentService assignmentService = new AssignmentService();

		List<DoctorPatientAssignment> assignments = assignmentService.getAllDoctorPatientAssignments();
        request.setAttribute("assignments", assignments);
        String contentPage = "views/assignment/doctorPatientAssignmentList.jsp";

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
