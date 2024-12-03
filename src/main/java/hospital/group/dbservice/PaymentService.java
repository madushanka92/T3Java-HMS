package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Payment;

public class PaymentService {

    // Save Payment
    public boolean savePayment(Payment payment) {
        String sql = "INSERT INTO Payments (patientId, serviceName, amount, paymentDate, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, payment.getPatientId());
            statement.setString(2, payment.getServiceName());
            statement.setDouble(3, payment.getAmount());
            statement.setDate(4, payment.getPaymentDate());
            statement.setString(5, payment.getStatus());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get Payments by Patient ID
    public List<Payment> getPaymentsByPatientId(int patientId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE patientId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, patientId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("paymentId"));
                payment.setPatientId(rs.getInt("patientId"));
                payment.setServiceName(rs.getString("serviceName"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentDate(rs.getDate("paymentDate"));
                payment.setStatus(rs.getString("status"));

                payments.add(payment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }
}
