package com.servlet;

import java.io.IOException;

import com.dao.DoctorDAO;
import com.db.DBConnection; // Assuming your connection class is named DBConnect
import com.entity.Doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// IMPORTANT: This annotation maps the URL path 'AddDoctor' to this Servlet.
@WebServlet("/AddDoctor")
public class AddDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get Form Data (matching input 'name' attributes from admin_add_doctor.jsp)
            String fullName = request.getParameter("fullname");
            String dob = request.getParameter("dob");
            String qualification = request.getParameter("qualification");
            String specialist = request.getParameter("specialist");
            String email = request.getParameter("email");
            String mobNo = request.getParameter("mobno");
            String password = request.getParameter("password");

            // 2. Package data into the Doctor Entity Object
            Doctor d = new Doctor(fullName, dob, qualification, specialist, email, mobNo, password);
            
            // 3. Instantiate DAO and call the insertion method
            DoctorDAO dao = new DoctorDAO(DBConnection.getConn());
            boolean f = dao.addDoctor(d);

            // Get the current session to send messages
            HttpSession session = request.getSession();

            // 4. Handle Response and Redirection
            if (f) {
                session.setAttribute("succMsg", "Doctor Added Successfully");
            } else {
                session.setAttribute("errorMsg", "Failed to add doctor. Something went wrong on server.");
            }
            
            // Redirect back to the Add Doctor form page
            response.sendRedirect("admin/admin_add_doctor.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any unexpected errors during processing
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "An unexpected error occurred during processing.");
            response.sendRedirect("admin/admin_add_doctor.jsp");
        }
	}
}