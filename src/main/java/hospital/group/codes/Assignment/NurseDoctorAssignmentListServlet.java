package hospital.group.codes.Assignment;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.AssignmentService;
import hospital.group.model.NurseDoctorAssignment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NurseDoctorAssignmentListServlet
 */
@WebServlet("/listNurseDoctorAssignments")
public class NurseDoctorAssignmentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public NurseDoctorAssignmentListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AssignmentService assignmentService = new AssignmentService();
        List<NurseDoctorAssignment> assignments = assignmentService.getAllNurseDoctorAssignments();
        request.setAttribute("assignments", assignments);

        String contentPage = "views/assignment/nurseDoctorAssignmentList.jsp";
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
