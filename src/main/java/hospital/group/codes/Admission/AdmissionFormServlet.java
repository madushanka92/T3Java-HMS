package hospital.group.codes.Admission;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import hospital.group.dbservice.AdmissionService;
import hospital.group.dbservice.PatientService;
import hospital.group.dbservice.UserService;
import hospital.group.model.Admission;
import hospital.group.model.Department;
import hospital.group.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdmissionFormServlet
 */
@WebServlet("/admissionForm")
public class AdmissionFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AdmissionService admissionService = new AdmissionService();
	private final UserService userService = new UserService();
	private final PatientService patienService = new PatientService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdmissionFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        Admission admission = id > 0 ? admissionService.getAdmissionById(id) : new Admission();

        List<Department> departments = userService.getAllDepartments();
    	List<Patient> patients = patienService.getAllPatients();

        request.setAttribute("departments", departments);
        request.setAttribute("patients", patients);

        request.setAttribute("admission", admission);

        String contentPage = "views/admission/create.jsp";

		request.setAttribute("contentPage", contentPage);

		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int admissionId = Integer.parseInt(request.getParameter("admissionId"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int roomId = request.getParameter("roomId") != null ? Integer.parseInt(request.getParameter("roomId")) : 0;
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        String status = request.getParameter("admissionStatus");
        String notes = request.getParameter("notes");

        String admissionDateStr = request.getParameter("admissionDate");

        System.out.println("admissionDateStr " + admissionDateStr);
        Timestamp admissionDate = null;
        if (admissionDateStr != null && !admissionDateStr.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date parsedDate = null;
			try {
				parsedDate = dateFormat.parse(admissionDateStr);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            admissionDate = new Timestamp(parsedDate.getTime());
        }

        Admission admission = new Admission(admissionId, patientId, roomId, departmentId, admissionDate, null, status, notes);

        boolean success;
        if (admissionId > 0) {
            success = admissionService.updateAdmission(admission);
        } else {
            success = admissionService.createAdmission(admission);
        }

//        response.sendRedirect("admissionList");

        if(success) {
    		response.sendRedirect(request.getContextPath() + "/admissionList");
        }
	}

}
