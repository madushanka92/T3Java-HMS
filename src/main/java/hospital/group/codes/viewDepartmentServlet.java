// In DepartmentServlet.java
package hospital.group.codes;

import java.io.IOException;
import java.util.List;

import hospital.group.dbservice.departmentService;
import hospital.group.model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/viewDepartment")
public class viewDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private departmentService departmentService = new departmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");


            List<Department> departmentList = departmentService.getAllDepartments();

            request.setAttribute("departmentList", departmentList);


            request.setAttribute("contentPage", "views/department/viewDepartment.jsp");
    		request.getRequestDispatcher("/user_layout.jsp").forward(request, response);

        }
}
