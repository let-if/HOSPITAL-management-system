package com.entity;

public class Appointment {
    private int id;
    private int userId;
    private String fullName;
    private String gender;
    private String age;
    private String appointDate; // Storing date as String for simplicity
    private String email;
    private String phNo;
    private String diseases;
    private int doctorId;
    private String address;
    private String status; // Pending, Confirmed, etc.

    // 1. Default Constructor (Required for fetching data from DB)
    public Appointment() {
        super();
    }

    // 2. Parameterized Constructor (Used when a user books a new appointment)
    public Appointment(int userId, String fullName, String gender, String age, 
                       String appointDate, String email, String phNo, 
                       String diseases, int doctorId, String address) {
        super();
        this.userId = userId;
        this.fullName = fullName;
        this.gender = gender;
        this.age = age;
        this.appointDate = appointDate;
        this.email = email;
        this.phNo = phNo;
        this.diseases = diseases;
        this.doctorId = doctorId;
        this.address = address;
        this.status = "Pending"; // Initial status when booked
    }

    // --- Getters and Setters (Accessors and Mutators) ---

    // ID
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // User ID
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    // Full Name
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    // Gender
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    // Age
    public String getAge() { return age; }
    public void setAge(String age) { this.age = age; }

    // Appointment Date
    public String getAppointDate() { return appointDate; }
    public void setAppointDate(String appointDate) { this.appointDate = appointDate; }

    // Email
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    // Phone Number
    public String getPhNo() { return phNo; }
    public void setPhNo(String phNo) { this.phNo = phNo; }

    // Diseases
    public String getDiseases() { return diseases; }
    public void setDiseases(String diseases) { this.diseases = diseases; }

    // Doctor ID
    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

    // Address
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    // Status
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

