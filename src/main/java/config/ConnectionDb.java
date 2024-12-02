package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDb {
    private static String url = "jdbc:mysql://localhost:3306/qlhs";
    private static String username = "root";
    private static String password = "";
    private static Connection conn = null;

    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Kết nối thất bại: " + e.getMessage());
        }
        return conn;
    }

    public static void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            if (conn != null) {
                System.out.println("Kết nối thành công!");
                return true;
            } else {
                System.out.println("Kết nối thất bại!");
                return false;
            }
        } catch (Exception e) {
            System.out.println("Kết nối thất bại: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }


    public static void main(String[] args) {
        boolean isConnected = testConnection();
        if (isConnected) {
            System.out.println("Kết nối đến cơ sở dữ liệu thành công!");
        } else {
            System.out.println("Không thể kết nối đến cơ sở dữ liệu!");
        }
    }
}