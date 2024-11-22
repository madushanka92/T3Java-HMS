package hospital.group.codes.Assignment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.dbservice.AssignmentService;
import hospital.group.dbservice.PatientService;
import hospital.group.dbservice.UserService;
import hospital.group.dbservice.departmentService;
import hospital.group.model.Department;
import hospital.group.model.Patient;
import hospital.group.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class createAssignmentServlet
 */
@WebServlet("/createAssignment")
public class createAssignmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public createAssignmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if no user is logged in
            return;
        }
        PatientService patientService = new PatientService();
        List<Patient> patientList = patientService.getAllPatients(); // Fetch all patients

        request.setAttribute("patientList", patientList);


		departmentService departmentService = new departmentService();

        List<Department> departmentList = departmentService.getAllDepartments();
        request.setAttribute("departmentList", departmentList);

        UserService userService = new UserService();
   	 	List<User> userList = userService.getAllUsers();


   	 	List<User> doctorList = userService.getAllUsers("Doctor");


        User loggedInUser = (User) session.getAttribute("loggedInUser");

        request.setAttribute("loggedInUser", loggedInUser);
        request.setAttribute("roleName", loggedInUser.getRoleName());
   	 	request.setAttribute("userList", userList);
   	 	request.setAttribute("doctorList", doctorList);


        String contentPage = "views/assignment/createAssignment.jsp";

        request.setAttribute("contentPage", contentPage);

	    request.getRequestDispatcher("/user_layout.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		AssignmentService assignmentService = new AssignmentService();

		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String roleName = request.getParameter("selectedRoleName");

        String targetId = request.getParameter("targetId");
        String notes = request.getParameter("notes");
        String additionalDetails = request.getParameter("additionalDetails");
        String assignmentType = request.getParameter("assignmentType");

        // Common parameters for all assignments
        Timestamp assignedDate = new Timestamp(System.currentTimeMillis());
        String status = "Active";

        int userId = Integer.parseInt(request.getParameter("userId"));


        try (Connection connection = DatabaseConnection.connect()) {
            switch (roleName.toLowerCase()) {
                case "doctor":
                    assignmentService.createDoctorPatientAssignment(connection,userId , targetId, notes, additionalDetails, assignedDate, status);
                    break;
                case "nurse":
                    assignmentService.createNurseDoctorAssignment(connection, userId, targetId, notes, additionalDetails, assignedDate, status);
                    break;
                case "technician":
                    if ("Patient".equalsIgnoreCase(assignmentType)) {
                    	String targetId1 = request.getParameter("patientTargetId");
                        String notes1 = request.getParameter("patientNotes");
                        String additionalDetails1 = request.getParameter("patientServiceType");
                        String scheduledDate = request.getParameter("scheduledDateTime");

                        assignmentService.createTechnicianPatientAssignment(connection, userId, targetId1, notes1, additionalDetails1, assignedDate, "Scheduled", scheduledDate);
                    } else if ("Department".equalsIgnoreCase(assignmentType)) {

                    	String targetId1 = request.getParameter("departmentTargetId");
                        String notes1 = request.getParameter("departmentNotes");
                        String additionalDetails1 = request.getParameter("departmentWorkShift");
                        String startDate = request.getParameter("departmentStartDate");

                        assignmentService.createTechnicianDepartmentAssignment(connection, userId, targetId1, notes1, additionalDetails1, assignedDate, status, startDate);
                    }
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/createAssignment?action=error");
                    return;
            }

            response.sendRedirect(request.getContextPath() + "/createAssignment?action=success");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/createAssignment?action=error");
        }
	}

}
