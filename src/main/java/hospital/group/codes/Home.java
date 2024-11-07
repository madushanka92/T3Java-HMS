package hospital.group.codes;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Home
 */
@WebServlet("/home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Home() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String path = request.getServletPath();
	    String contentPage = "views/" + path + ".jsp";

	    // Check if the content page exists
	    if (isPageValid(contentPage)) {
	        request.setAttribute("contentPage", contentPage); // Set the content page attribute
	    } else {
	        contentPage = "/views/404.jsp"; // Default to 404 if the page is not found
	        request.setAttribute("contentPage", contentPage);
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
		// doGet(request, response);

//		String path = request.getServletPath();
        String title = "views/home.jsp";
        String contentPage = "views/home.jsp";

        // Set attributes for title and contentPage
        request.setAttribute("title", title);
        request.setAttribute("contentPage", contentPage);

        // Forward to layout.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("user_layout.jsp");
        dispatcher.forward(request, response);
	}

}
