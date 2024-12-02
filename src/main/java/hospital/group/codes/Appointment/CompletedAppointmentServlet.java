package hospital.group.codes.Appointment;

import java.io.IOException;

import hospital.group.dbservice.AppointmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CompletedAppointmentServlet
 */
@WebServlet("/markAsCompleted")
public class CompletedAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompletedAppointmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // Get appointment ID and doctor ID from the request
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));

        // Create an instance of AppointmentService to handle the update
        AppointmentService appointmentService = new AppointmentService();

        // Update the appointment status to "Completed"
        boolean success = appointmentService.markAppointmentAsCompleted(appointmentId);

        if (success) {
            // Redirect to the appointment list page with updated status
//            response.sendRedirect("doctorAppointments");


        	 response.sendRedirect(request.getContextPath() + "/doctor-appointments");
        } else {
            response.sendRedirect(request.getContextPath() + "404.jsp");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
	}

}
