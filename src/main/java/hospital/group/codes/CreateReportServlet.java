package hospital.group.codes;

import java.io.IOException;
import java.time.LocalDate;
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

@WebServlet("/createReport")
public class CreateReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Your logic here, e.g., forwarding to the JSP page
    	String action = request.getParameter("action");
    	if("success".equals(action)) {
    		request.setAttribute("contentPage", "views/patient/SuccessFullyAdded.jsp");
    	}


    	else {
    		List<Patient> patientList = PatientService.getAllPatients();



        // Set as a request attribute
    		request.setAttribute("patientList", patientList);
    		request.setAttribute("contentPage", "/views/patient/newRecord.jsp");
    		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
    }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form data
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            LocalDate reportDate = LocalDate.parse(request.getParameter("reportDate"));

            // Create a Report object
            Report report = new Report(patientId, diagnosis, treatment, reportDate);

            // Add the report to the database
            boolean isSaved = reportService.addReport(report);

            // Redirect to reports list page or show error message
            if (isSaved) {
                response.sendRedirect(request.getContextPath() + "/createReport?action=success");
            } else {
                response.sendRedirect(request.getContextPath() + "404.jsp");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid input. Please try again.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
}
