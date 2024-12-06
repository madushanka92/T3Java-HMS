package hospital.group.codes.Users;

import java.io.IOException;

import hospital.group.dbservice.UserService;
import hospital.group.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
//        	String usernameStr = (String) session.getAttribute("user");
//        	Integer username = Integer.parseInt(usernameStr);
        	

    		User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

    		Integer username = loggedInUser.getUserId();


            // Fetch user details
            User user = userService.getUserByUsername(username);
            if (user != null) {
                request.setAttribute("user", user);
//                request.setAttribute("lastName", user.getLastName());
//                request.setAttribute("email", user.getEmail());
//                request.setAttribute("contactNumber", user.getContactNumber());
//                request.setAttribute("address", user.getAddress());


                request.setAttribute("contentPage", "views/user/profile.jsp");
//                List<User> userList = UserService.getAllUsers();


        		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
