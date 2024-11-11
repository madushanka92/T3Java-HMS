package hospital.group.codes;

import java.io.IOException;

import hospital.group.dbservice.PatientService;
import hospital.group.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editPatient")
public class EditPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PatientService patientService = new PatientService();

    public EditPatientServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(request.getParameter("id")); // Get the patient ID from the URL parameter
            Patient patient = patientService.getPatientById(patientId); // Retrieve the patient data by ID

            if (patient != null) {
                request.setAttribute("patient", patient);
//                request.getRequestDispatcher("/views/editPatient.jsp").forward(request, response);
            } else {
//                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
//            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }
        request.setAttribute("contentPage", "views/editPatient.jsp");
		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
    }
}



