package com.servlet;

import java.io.IOException;

import com.dao.AppointmentDAO;
import com.db.DBConnection;
import com.entity.Appointment;
import com.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// IMPORTANT: This annotation maps the URL path 'AddAppointment' to this Servlet.
@WebServlet("/AddAppointment")
public class AddAppointment extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get Form Data (matching input 'name' attributes from appointment.jsp)
        // User ID is hidden field
        int userId = Integer.parseInt(request.getParameter("userid"));
        
        String fullName = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");
        String appointDate = request.getParameter("appoint_date");
        String email = request.getParameter("email");
        String phNo = request.getParameter("phno");
        String diseases = request.getParameter("diseases");
        // Doctor ID comes from the selected option value
        int doctorId = Integer.parseInt(request.getParameter("doctor"));
        
        String address = request.getParameter("address");

        // 2. Package data into the Appointment Entity Object
        Appointment ap = new Appointment(userId, fullName, gender, age, 
                                         appointDate, email, phNo, diseases, 
                                         doctorId, address);
        
        // 3. Instantiate DAO and check the result
        AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
        HttpSession session = request.getSession();
        
        boolean f = dao.addAppointment(ap);

        // 4. Handle Response and Redirection
        if (f) {
            session.setAttribute("succMsg", "Appointment booked successfully!");
            response.sendRedirect("appointment.jsp"); // Send back to the form with success message
        } else {
            session.setAttribute("errorMsg", "Failed to book appointment. Server error.");
            response.sendRedirect("appointment.jsp"); // Send back to the form with error message
        }
	}
}

