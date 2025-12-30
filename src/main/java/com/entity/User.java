package com.entity;



public class User {
    // These fields match the columns in the 'user_details' table
    private int id;
    private String fullName;
    private String email;
    private String password;

    // --- 1. Default Constructor (Required by the DAO) ---
    // The DAO uses this when mapping data fetched from the database (ResultSet).
    public User() {
    }

    // --- 2. Registration Constructor ---
    // Used when creating a new User object from the registration form data.
    public User(String fullName, String email, String password) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }

    // --- 3. Getters and Setters (Accessors and Mutators) ---
    
    // You can use Eclipse shortcut: Right-click > Source > Generate Getters and Setters...

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}