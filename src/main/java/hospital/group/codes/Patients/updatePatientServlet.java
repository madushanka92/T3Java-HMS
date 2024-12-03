package hospital.group.codes.Patients;

import java.io.IOException;

import hospital.group.dbservice.PatientService;
import hospital.group.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updatePatient")
public class updatePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PatientService patientService = new PatientService();

    public updatePatientServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String gender = request.getParameter("gender");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String emergencyContact = request.getParameter("emergencyContact");
            String medicalHistory = request.getParameter("medicalHistory");

            // Update patient details
            Patient updatedPatient = new Patient(patientId, firstName, lastName, java.sql.Date.valueOf(dateOfBirth), gender, contactNumber, email, address, emergencyContact, medicalHistory);
            boolean isUpdated = patientService.updatePatient(updatedPatient);

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/viewPatient");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }

    }
}
