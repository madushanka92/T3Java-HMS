package hospital.group.codes;

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
 * Servlet implementation class viewPatient
 */
@WebServlet("/viewPatient")
public class viewPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static PatientService patientService = new PatientService();

    public viewPatientServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        // Forwarding the data to viewPatient.jsp
    	List<Patient> patientList = patientService.getAllPatients();

        request.setAttribute("patientList", patientList);
        request.setAttribute("contentPage", "views/viewPatient.jsp");
		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
