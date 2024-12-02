package hospital.group.codes;

import java.io.IOException;
import java.sql.Date;

import hospital.group.dbservice.PaymentService;
import hospital.group.model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/paymentForm")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PaymentService paymentService = new PaymentService();

    public PaymentServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("contentPage", "views/payment/paymentForm.jsp");
        request.getRequestDispatcher("/user_layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        String serviceName = request.getParameter("serviceName");
        double amount = Double.parseDouble(request.getParameter("amount"));
        Date paymentDate = Date.valueOf(request.getParameter("paymentDate"));
        String status = request.getParameter("status");

        Payment payment = new Payment(0, patientId, serviceName, amount, paymentDate, status);

        boolean isSaved = paymentService.savePayment(payment);

        if (isSaved) {
            response.sendRedirect(request.getContextPath() + "/paymentForm?action=success");
        } else {
            response.sendRedirect("views/error.jsp");
        }
    }
}
