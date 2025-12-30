package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.User;

public class UserDAO {

    private Connection conn;

    // Constructor: Takes the database connection (from DBConnect) when the DAO is instantiated
    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // --- 1. User Register Method (C: Create) ---
    public boolean userRegister(User u) {
        boolean f = false; // Flag to check success/failure

        try {
            // Use PreparedStatement for security and efficiency (prevents SQL injection)
            String sql = "INSERT INTO user_details (full_name, email, password) VALUES (?, ?, ?)";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            // Set values from the User object (u) into the SQL query parameters (?)
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            
            // Execute the update (INSERT operation)
            int i = ps.executeUpdate();

            if (i == 1) {
                f = true; // Set flag to true on successful insertion (one row affected)
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // --- 2. User Login Method (R: Read) ---
    public User login(String em, String psd) {
        User u = null; // Initialize the User object to null

        try {
            // SQL query to find a user matching the email AND password
            String sql = "SELECT * FROM user_details WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, em);
            ps.setString(2, psd);

            // Execute the query (SELECT operation)
            ResultSet rs = ps.executeQuery();
            
            // If rs.next() is true, a matching user was found
            if (rs.next()) {
                u = new User();
                // Map the data from the database (ResultSet) into the User entity object
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return u; // Returns the User object if successful, or null if login failed
    }
}