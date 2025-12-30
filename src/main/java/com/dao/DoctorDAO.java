package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Doctor;

public class DoctorDAO {

    private Connection conn;

    public DoctorDAO(Connection conn) {
        this.conn = conn;
    }
    
    // Method to insert a new Doctor record into the database
    public boolean addDoctor(Doctor d) {
        boolean f = false;

        try {
            // SQL statement: Note that 'id' is AUTO_INCREMENT, so we skip it.
            String sql = "INSERT INTO doctor (full_name, dob, qualification, specialist, email, mobno, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            // Bind the data from the Doctor object (7 fields)
            ps.setString(1, d.getFullName());
            ps.setString(2, d.getDob());
            ps.setString(3, d.getQualification());
            ps.setString(4, d.getSpecialist());
            ps.setString(5, d.getEmail());
            ps.setString(6, d.getMobNo());
            ps.setString(7, d.getPassword());
            
            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
 // Method to retrieve all doctor records
    public List<Doctor> getAllDoctor() {
        List<Doctor> list = new ArrayList<Doctor>();
        Doctor d = null;

        try {
            String sql = "SELECT * FROM doctor ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                d = new Doctor();
                // Map data from the ResultSet to the Doctor object
                d.setId(rs.getInt(1));
                d.setFullName(rs.getString(2));
                d.setDob(rs.getString(3));
                d.setQualification(rs.getString(4));
                d.setSpecialist(rs.getString(5));
                d.setEmail(rs.getString(6));
                d.setMobNo(rs.getString(7));
                d.setPassword(rs.getString(8));
                
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
 // Method to delete a doctor record by ID
    public boolean deleteDoctor(int id) {
        boolean f = false;

        try {
            // SQL statement to delete the row where the ID matches
            String sql = "DELETE FROM doctor WHERE id=?";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            
            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
 // Method to retrieve a single doctor record by ID
    public Doctor getDoctorById(int id) {
        Doctor d = null;
        try {
            // 1. Select all fields for the specified ID
            String sql = "SELECT * FROM doctor WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            // 2. Process the single result
            if (rs.next()) {
                d = new Doctor();
                // Map data from ResultSet to Doctor object
                d.setId(rs.getInt(1));
                d.setFullName(rs.getString(2));
                d.setDob(rs.getString(3));
                d.setQualification(rs.getString(4));
                d.setSpecialist(rs.getString(5));
                d.setEmail(rs.getString(6));
                d.setMobNo(rs.getString(7));
                d.setPassword(rs.getString(8)); // Note: Usually, you don't expose/edit the password this way, but we will keep it consistent with the table structure for now.
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }
    
 // Method to update an existing Doctor record
    public boolean updateDoctor(Doctor d) {
        boolean f = false;

        try {
            // SQL statement to UPDATE the record based on the ID
            // Note: ID is passed as the last parameter in the query execution.
            String sql = "UPDATE doctor SET full_name=?, dob=?, qualification=?, specialist=?, email=?, mobno=?, password=? WHERE id=?";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            // 1. Bind the updated data (7 fields)
            ps.setString(1, d.getFullName());
            ps.setString(2, d.getDob());
            ps.setString(3, d.getQualification());
            ps.setString(4, d.getSpecialist());
            ps.setString(5, d.getEmail());
            ps.setString(6, d.getMobNo());
            ps.setString(7, d.getPassword());
            
            // 2. Bind the ID (the WHERE clause condition)
            ps.setInt(8, d.getId()); 
            
            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
    public Doctor loginDoctor(String email, String password) {
        Doctor d = null;

        try {
            // SQL statement to find a doctor with matching email and password
            String sql = "SELECT * FROM doctor WHERE email=? AND password=?";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Doctor found, map the data to the Doctor object
                d = new Doctor();
                d.setId(rs.getInt(1));
                d.setFullName(rs.getString(2));
                d.setDob(rs.getString(3));
                d.setQualification(rs.getString(4));
                d.setSpecialist(rs.getString(5));
                d.setEmail(rs.getString(6));
                d.setMobNo(rs.getString(7));
                d.setPassword(rs.getString(8)); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return d;
    }
}

