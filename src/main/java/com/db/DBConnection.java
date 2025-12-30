package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    private static Connection conn;

    public static Connection getConn() {
        try {

        	if (conn == null || conn.isClosed()) {
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                
                String url = "jdbc:mysql://localhost:3306/hospital_management_system";
                String user = "root";       
                String password = "root";   
                
                conn = DriverManager.getConnection(url, user, password);
                
                System.out.println("Database Connected Successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR: Failed to connect to database. Check MySQL server status and credentials.");
        }
        return conn;
    }

    public static void main(String[] args) {
        Connection testConn = DBConnection.getConn();
        if (testConn != null) {
            System.out.println("Test Status: SUCCESS - Connection object is not null.");
        } else {
            System.out.println("Test Status: FAILURE - Connection object is null.");
        }
    }
}