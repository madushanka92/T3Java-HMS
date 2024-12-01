package hospital.group.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/HMS";
    private static final String USER = "root";
    private static final String PASSWORD = "root@2024";

    public static Connection connect() {
        Connection connection = null;
        try {
        	 // Register the driver (optional for newer versions)
            Class.forName("com.mysql.cj.jdbc.Driver");
        	connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connected to the database successfully!");
        }catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
}