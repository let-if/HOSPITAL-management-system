package com.servlet;

import java.io.IOException;

import com.dao.AppointmentDAO;
import com.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Maps the form action from the doctor JSP
@WebServlet("/DoctorUpdateStatus")
public class DoctorUpdateStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get ALL form data
        int apId = Integer.parseInt(request.getParameter("id"));
        int doctId = Integer.parseInt(request.getParameter("doctId")); // The doctor who is logged in
        String status = request.getParameter("status");
        // String comment = request.getParameter("comment"); // If you implement a comment field

        // 2. Instantiate DAO and call the update method
        AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
        boolean f = dao.updateAppointmentStatus(apId, doctId, status); 

        HttpSession session = request.getSession();

        // 3. Handle Response and Redirection
        if (f) {
            session.setAttribute("succMsg", "Appointment Status Updated Successfully");
        } else {
            session.setAttribute("errorMsg", "Failed to update appointment status.");
        }
        
        // Redirect back to the Doctor Dashboard
        response.sendRedirect("doctor/doctor_dashboard.jsp");
	}
}