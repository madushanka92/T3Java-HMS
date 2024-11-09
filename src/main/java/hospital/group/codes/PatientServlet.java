package hospital.group.codes;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import hospital.group.dbservice.PatientService;
import hospital.group.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PatientServlet
 */
@WebServlet("/patientForm")
public class PatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final PatientService patienService = new PatientService();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PatientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		if ("success".equals(action)) {
			request.setAttribute("contentPage", "views/patientSuccess.jsp");
        }else {
        	String path = request.getServletPath();
    	    String contentPage = "views/" + path + ".jsp";

    	    // Check if the content page exists
    	    if (isPageValid(contentPage)) {
    	        request.setAttribute("contentPage", contentPage); // Set the content page attribute
    	    } else {
    	        contentPage = "/views/404.jsp"; // Default to 404 if the page is not found
    	        request.setAttribute("contentPage", contentPage);
    	    }
        }


	    request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
	}


	// Method to check if the page exists
	private boolean isPageValid(String pagePath) {
	    // You can check if the JSP file exists in the specified directory
	    File file = new File(getServletContext().getRealPath(pagePath));
	    return file.exists();
	}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);

		String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        Date dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
        String gender = request.getParameter("gender");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String emergencyContact = request.getParameter("emergencyContact");
        String medicalHistory = request.getParameter("medicalHistory");

        // Create a Patient object
        Patient newPatient = new Patient(0, firstName, lastName, dateOfBirth, gender, contactNumber, email, address, emergencyContact, medicalHistory);

        boolean isSaved = patienService.savePatient(newPatient);

        // Check if save was successful and redirect accordingly
        if (isSaved) {
            response.sendRedirect(request.getContextPath() + "/patientForm?action=success"); // Redirect to success page
        } else {
            response.sendRedirect("views/error.jsp"); // Redirect to error page if save fails
        }

	}

}
