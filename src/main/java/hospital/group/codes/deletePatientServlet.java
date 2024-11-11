package hospital.group.codes;

import java.io.IOException;

import hospital.group.dbservice.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deletePatient")
public class deletePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PatientService patientService = new PatientService();

    public deletePatientServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(request.getParameter("id")); // Get the patient ID from the URL

            boolean isDeleted = patientService.deletePatient(patientId); // Delete the patient

            if (isDeleted) {
                response.sendRedirect(request.getContextPath() + "/viewPatient"); // Redirect to patient list page
            } else {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }
    }
}
