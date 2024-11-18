package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import hospital.group.db.DatabaseConnection;
import hospital.group.model.Report;
import hospital.group.dbservice.*;

public class ReportService {

    // Method to add a new report
    public boolean addReport(Report report) {
        String query = "INSERT INTO Reports (patientId, diagnosis, treatment, reportDate) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, report.getPatientId());
            statement.setString(2, report.getDiagnosis());
            statement.setString(3, report.getTreatment());
            statement.setDate(4, java.sql.Date.valueOf(report.getReportId()));

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
