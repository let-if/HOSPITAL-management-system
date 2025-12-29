package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Appointment;
import com.entity.User;

public class AppointmentDAO {

    private Connection conn;

    public AppointmentDAO(Connection conn) {
        this.conn = conn;
    }


    public boolean addAppointment(Appointment ap) {
        boolean f = false;

        try {
            String sql = "INSERT INTO appointment (user_id, fullname, gender, age, appoint_date, email, phno, diseases, doctor_id, address, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, ap.getUserId());
            ps.setString(2, ap.getFullName());
            ps.setString(3, ap.getGender());
            ps.setString(4, ap.getAge());
            ps.setString(5, ap.getAppointDate());
            ps.setString(6, ap.getEmail());
            ps.setString(7, ap.getPhNo());
            ps.setString(8, ap.getDiseases());
            ps.setInt(9, ap.getDoctorId());
            ps.setString(10, ap.getAddress());
            ps.setString(11, ap.getStatus());
            
            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }


public List<Appointment> getAllAppointmentByUserId(int userId) {
 List<Appointment> list = new ArrayList<Appointment>();
 Appointment ap = null;

 try {
     String sql = "SELECT * FROM appointment WHERE user_id=? ORDER BY id DESC";

     // 2. Prepare the statement
     PreparedStatement ps = conn.prepareStatement(sql);
     ps.setInt(1, userId); // Bind the user_id passed to the method

     // 3. Execute the query
     ResultSet rs = ps.executeQuery();

     // 4. Process the results (loop through each row/appointment)
     while (rs.next()) {
         ap = new Appointment();
         // Map data from the ResultSet (database) to the Appointment object (Java)
         ap.setId(rs.getInt(1));
         ap.setUserId(rs.getInt(2));
         ap.setFullName(rs.getString(3));
         ap.setGender(rs.getString(4));
         ap.setAge(rs.getString(5));
         ap.setAppointDate(rs.getString(6));
         ap.setEmail(rs.getString(7));
         ap.setPhNo(rs.getString(8));
         ap.setDiseases(rs.getString(9));
         ap.setDoctorId(rs.getInt(10));
         ap.setAddress(rs.getString(11));
         ap.setStatus(rs.getString(12));

         list.add(ap); // Add the fully populated Appointment object to the list
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return list;
}
//Method to retrieve all appointments in the system (for Admin view)
public List<Appointment> getAllAppointment() {
 List<Appointment> list = new ArrayList<Appointment>();
 Appointment ap = null;

 try {
     // 1. Define the SQL SELECT statement (NO WHERE clause)
     String sql = "SELECT * FROM appointment ORDER BY id DESC";

     // 2. Prepare and execute the statement
     PreparedStatement ps = conn.prepareStatement(sql);
     ResultSet rs = ps.executeQuery();

     // 3. Process the results (loop through each row/appointment)
     while (rs.next()) {
         ap = new Appointment();
         // Map data from the ResultSet to the Appointment object
         ap.setId(rs.getInt(1));
         ap.setUserId(rs.getInt(2));
         ap.setFullName(rs.getString(3));
         ap.setGender(rs.getString(4));
         ap.setAge(rs.getString(5));
         ap.setAppointDate(rs.getString(6));
         ap.setEmail(rs.getString(7));
         ap.setPhNo(rs.getString(8));
         ap.setDiseases(rs.getString(9));
         ap.setDoctorId(rs.getInt(10));
         ap.setAddress(rs.getString(11));
         ap.setStatus(rs.getString(12));

         list.add(ap); 
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return list;
}
//Method to update the status of an appointment
public boolean updateAppointmentStatus(int apId, int doctId, String status) {
 boolean f = false;

 try {
     // SQL statement to UPDATE the status and doctor ID for the given appointment ID
     String sql = "UPDATE appointment SET doctor_id=?, status=? WHERE id=?";
     
     PreparedStatement ps = conn.prepareStatement(sql);
     
     // Bind the updated data
     ps.setInt(1, doctId);    // The doctor who confirmed/handled the status
     ps.setString(2, status); // The new status (e.g., "Confirmed")
     
     // Bind the ID (the WHERE clause condition)
     ps.setInt(3, apId); 
     
     int i = ps.executeUpdate();

     if (i == 1) {
         f = true;
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return f;
}
//Method to retrieve all appointments assigned to a specific doctor
public List<Appointment> getAllAppointmentByDoctorId(int doctorId) {
 List<Appointment> list = new ArrayList<Appointment>();
 Appointment ap = null;

 try {
     // 1. Define the SQL SELECT statement with a WHERE clause for doctor_id
     String sql = "SELECT * FROM appointment WHERE doctor_id=? ORDER BY id DESC";

     // 2. Prepare the statement and bind the doctorId
     PreparedStatement ps = conn.prepareStatement(sql);
     ps.setInt(1, doctorId); 
     
     ResultSet rs = ps.executeQuery();

     // 3. Process the results
     while (rs.next()) {
         ap = new Appointment();
         // Map data from the ResultSet to the Appointment object
         ap.setId(rs.getInt(1));
         ap.setUserId(rs.getInt(2));
         ap.setFullName(rs.getString(3));
         ap.setGender(rs.getString(4));
         ap.setAge(rs.getString(5));
         ap.setAppointDate(rs.getString(6));
         ap.setEmail(rs.getString(7));
         ap.setPhNo(rs.getString(8));
         ap.setDiseases(rs.getString(9));
         ap.setDoctorId(rs.getInt(10));
         ap.setAddress(rs.getString(11));
         ap.setStatus(rs.getString(12));

         list.add(ap); 
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return list;
}
}

