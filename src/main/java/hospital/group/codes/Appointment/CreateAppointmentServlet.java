package hospital.group.codes.Appointment;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import hospital.group.dbservice.AppointmentService;
import hospital.group.dbservice.PatientService;
import hospital.group.dbservice.UserService;
import hospital.group.dbservice.departmentService;
import hospital.group.model.Appointment;
import hospital.group.model.Department;
import hospital.group.model.Patient;
import hospital.group.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateAppointmentServlet
 */
@WebServlet("/create-appointment")
public class CreateAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAppointmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		UserService userService = new UserService();
        departmentService departmentService = new departmentService();

        PatientService patientService = new PatientService();
        List<Patient> patientList = patientService.getAllPatients(); // Fetch all patients

        // Fetch doctors and departments for selection in the form
        List<User> doctors = userService.getAllUsers("Doctor");
        List<Department> departments = departmentService.getAllDepartments();

        request.setAttribute("doctors", doctors);
        request.setAttribute("departments", departments);
        request.setAttribute("patientList", patientList);


        String contentPage = "views/appointment/create-appointment.jsp";

        request.setAttribute("contentPage", contentPage);

	    request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int patientId = Integer.parseInt(request.getParameter("patientId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        Date appointmentDate = Date.valueOf(request.getParameter("appointmentDate"));
        Time appointmentTime = Time.valueOf(request.getParameter("appointmentTime") + ":00");
        String status = request.getParameter("status");
        String type = request.getParameter("type");

        AppointmentService appointmentService = new AppointmentService();
        Appointment appointment = appointmentService.createAppointment(patientId, doctorId, departmentId, appointmentDate, appointmentTime, status, type);

        if (appointment != null) {
            request.setAttribute("appointment", appointment);

            String contentPage = "views/appointment/appointment-created.jsp";

            request.setAttribute("contentPage", contentPage);

    	    request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
        } else {
            response.getWriter().write("Error occurred while scheduling the appointment.");
        }
	}

}
