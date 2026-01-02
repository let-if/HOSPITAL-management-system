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


@WebServlet("/UpdateAppointmentStatus")
public class UpdateAppointmentStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get ALL form data
        int apId = Integer.parseInt(request.getParameter("id"));
        int doctId = Integer.parseInt(request.getParameter("doctId"));
        String status = request.getParameter("status");

        // 2. Instantiate DAO and call the update method
        AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
        // The DAO method we created in Step 23 handles the update
        boolean f = dao.updateAppointmentStatus(apId, doctId, status); 

        HttpSession session = request.getSession();

        // 3. Handle Response and Redirection
        if (f) {
            session.setAttribute("succMsg", "Appointment Status Updated Successfully");
            // Redirect back to the main Admin View Appointments page
            response.sendRedirect("admin/admin_view_appointment.jsp");
        } else {
            session.setAttribute("errorMsg", "Failed to update appointment status.");
            // Redirect back to the Edit page
            response.sendRedirect("admin/admin_edit_appointment.jsp?id=" + apId);
        }
	}
}