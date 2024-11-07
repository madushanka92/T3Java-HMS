package hospital.group.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter("/*")
public class AuthenticationFilter extends HttpFilter implements Filter {

    private static final long serialVersionUID = 1L;

	/**
     * @see HttpFilter#HttpFilter()
     */
    public AuthenticationFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(false);

        String loginURI = request.getContextPath() + "/login";
        boolean isLoginPage = request.getRequestURI().equals(loginURI);
        boolean isLoggedIn = session != null && session.getAttribute("user") != null;
        boolean isResource = request.getRequestURI().startsWith(request.getContextPath() + "/assets/");

        if (isLoggedIn || isLoginPage || isResource) {
            chain.doFilter(request, response);
        } else {
        	String errorParam = request.getParameter("error");
            if (errorParam != null) {
                response.sendRedirect(loginURI + "?error=" + errorParam);
            } else {
                response.sendRedirect(loginURI);
            }
        }
    }

}