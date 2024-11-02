package hospital.group.codes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;

/**
 * Servlet implementation class AboutServlet
 */
@WebServlet("/about")
public class AboutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AboutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath(); // Get the servlet path
	    String contentPage = "views/" + path + ".jsp"; // Construct the content page path
	    

        System.out.println("## A : " + contentPage);

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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}