package hospital.group.codes;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.PatientService;
import hospital.group.dbservice.ReportService;
import hospital.group.model.Patient;
import hospital.group.model.Report;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/viewReport")
public class ViewReportServlet extends HttpServlet {
    private ReportService reportService;
    private static PatientService patientService = new PatientService();

    @Override
    public void init() throws ServletException {
        reportService = new ReportService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all patients for the dropdown
            List<Patient> patientList = patientService.getAllPatients();
            request.setAttribute("patientList", patientList);

            // Check if a patientId is selected
            String patientIdParam = request.getParameter("patientId");
            if (patientIdParam != null && !patientIdParam.isEmpty()) {
                int patientId = Integer.parseInt(patientIdParam);
                Report reports = reportService.getReportById(Integer.valueOf(patientId));
                request.setAttribute("reports", reports);
            }

            // Forward to JSP
            request.getRequestDispatcher("/views/patient/viewReport.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error retrieving reports", e);
        }
    }
}
