package hospital.group.codes.Appointment;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.AppointmentService;
import hospital.group.model.Appointment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DoctorAppointmentServlet
 */
@WebServlet("/doctor-appointments")
public class DoctorAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoctorAppointmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int doctorId = (int) request.getSession().getAttribute("userId");

        AppointmentService appointmentService = new AppointmentService();
        List<Appointment> appointments = appointmentService.getAppointmentsForDoctor(doctorId);

        // Set the list of appointments in the request scope to be accessed in JSP
        request.setAttribute("appointments", appointments);


        String contentPage = "views/appointment/doctor-appointments.jsp";

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
