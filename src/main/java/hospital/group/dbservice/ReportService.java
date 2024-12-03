package hospital.group.dbservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hospital.group.db.DatabaseConnection;
import hospital.group.model.Report;

public class ReportService {

    // Method to add a new report
    public boolean addReport(Report report) {
        String query = "INSERT INTO Reports (patientId, diagnosis, treatment, reportDate) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, report.getPatientId());
            statement.setString(2, report.getDiagnosis());
            statement.setString(3, report.getTreatment());
            statement.setDate(4, java.sql.Date.valueOf(report.getReportDate()));

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to fetch all reports
    public List<Report> getAllReports() {
        String query = "SELECT * FROM Reports";
        List<Report> reports = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Report report = new Report(
                    rs.getInt("patientId"),
                    rs.getString("diagnosis"),
                    rs.getString("treatment"),
                    rs.getDate("reportDate").toLocalDate()
                );
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    // Method to update an existing report
    public boolean updateReport(Report report) {
        String query = "UPDATE Reports SET patientId = ?, diagnosis = ?, treatment = ?, reportDate = ? WHERE reportId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, report.getPatientId());
            statement.setString(2, report.getDiagnosis());
            statement.setString(3, report.getTreatment());
            statement.setDate(4, java.sql.Date.valueOf(report.getReportDate()));
            statement.setString(5, report.getReportId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to delete a report by reportId
    public boolean deleteReport(String reportId) {
        String query = "DELETE FROM Reports WHERE reportId = ?";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, reportId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to fetch a single report by reportId
 // Fetch all reports by patient ID
    public List<Report> getReportsByPatientId(int patientId) {
        String query = "SELECT reportId, patientId, diagnosis, treatment, reportDate FROM Reports WHERE patientId = ?";
        List<Report> reports = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, patientId);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Report report = new Report(
                        rs.getInt("reportId"),       // Ensure this matches the Report constructor
                        rs.getInt("patientId"),
                        rs.getString("diagnosis"),
                        rs.getString("treatment"),
                        rs.getDate("reportDate").toLocalDate()
                    );
                    reports.add(report);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }
}

