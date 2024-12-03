package hospital.group.codes.Assignment;

import java.io.IOException;

import hospital.group.dbservice.UserService;
import hospital.group.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetRoleDetailsServlet
 */
@WebServlet("/getRoleDetails")
public class GetRoleDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetRoleDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserService userService = new UserService();
		int userId = Integer.parseInt(request.getParameter("userId"));
        User user = userService.getUserById(userId);  // Fetch the user by ID from the database
        String roleName = user.getRoleName();

        StringBuilder htmlResponse = new StringBuilder();

        // Generate dynamic form fields based on the user's role
        if ("Doctor".equalsIgnoreCase(roleName)) {
            htmlResponse.append("<label for='targetId'>Patient ID:</label>");
            htmlResponse.append("<input type='number' name='targetId' required />");
            htmlResponse.append("<label for='notes'>Notes:</label>");
            htmlResponse.append("<textarea name='notes'></textarea>");
            htmlResponse.append("<label for='additionalDetails'>Is Primary Doctor:</label>");
            htmlResponse.append("<select name='additionalDetails'><option value='true'>Yes</option><option value='false'>No</option></select>");
        } else if ("Nurse".equalsIgnoreCase(roleName)) {
            htmlResponse.append("<label for='targetId'>Doctor ID:</label>");
            htmlResponse.append("<input type='number' name='targetId' required />");
            htmlResponse.append("<label for='notes'>Notes:</label>");
            htmlResponse.append("<textarea name='notes'></textarea>");
            htmlResponse.append("<label for='additionalDetails'>Shift Type:</label>");
            htmlResponse.append("<select name='additionalDetails'><option value='Morning'>Morning</option><option value='Afternoon'>Afternoon</option><option value='Night'>Night</option><option value='All Day'>All Day</option></select>");
        } else if ("Technician".equalsIgnoreCase(roleName)) {
            htmlResponse.append("<label for='assignmentTarget'>Assignment Type:</label>");
            htmlResponse.append("<select name='assignmentType' onchange='toggleTechnicianFields(this.value)'><option value='Patient'>Patient</option><option value='Department'>Department</option></select>");
            htmlResponse.append("<div id='patientFields'><label for='targetId'>Patient ID:</label><input type='number' name='targetId' /><label for='notes'>Notes:</label><textarea name='notes'></textarea><label for='additionalDetails'>Service Type:</label><select name='additionalDetails'><option value='Lab'>Lab</option><option value='Radiology'>Radiology</option><option value='Cardiology'>Cardiology</option><option value='Neurology'>Neurology</option><option value='Respiratory'>Respiratory</option></select></div>");
            htmlResponse.append("<div id='departmentFields' style='display:none;'><label for='targetId'>Department ID:</label><input type='number' name='targetId' /><label for='notes'>Notes:</label><textarea name='notes'></textarea><label for='additionalDetails'>Work Shift:</label><select name='additionalDetails'><option value='Morning'>Morning</option><option value='Afternoon'>Afternoon</option><option value='Night'>Night</option><option value='Rotational'>Rotational</option></select><label for='startDate'>Start Date:</label><input type='date' name='startDate' /></div>");
        }

        response.setContentType("text/html");
        response.getWriter().write(htmlResponse.toString());
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
