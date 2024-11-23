package hospital.group.codes.Patients;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.PatientService;
import hospital.group.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchPatientServlet
 */
@WebServlet("/SearchPatientServlet")
public class SearchPatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchPatientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String searchQuery = request.getParameter("q");  // Get the search query from the request

        PatientService patientService = new PatientService();
        List<Patient> patients = patientService.searchPatients(searchQuery);

        // Convert the list of patients to a JSON format
        StringBuilder json = new StringBuilder("[");
        for (Patient patient : patients) {
            json.append("{")
                .append("\"patientId\":").append(patient.getPatientId()).append(",")
                .append("\"text\":\"").append(patient.getFirstName()).append(" ").append(patient.getLastName()).append("\"")
                .append("},");
        }

        if (!patients.isEmpty()) {
            json.setLength(json.length() - 1);  // Remove the last comma
        }

        json.append("]");

        response.setContentType("application/json");
        response.getWriter().write(json.toString());
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
