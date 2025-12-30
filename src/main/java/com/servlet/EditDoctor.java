package com.servlet;

import java.io.IOException;

import com.dao.DoctorDAO;
import com.db.DBConnection;
import com.entity.Doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// IMPORTANT: This annotation maps the URL path 'EditDoctor' to this Servlet.
@WebServlet("/EditDoctor")
public class EditDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get ALL form data, including the hidden ID field
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullname");
            String dob = request.getParameter("dob");
            String qualification = request.getParameter("qualification");
            String specialist = request.getParameter("specialist");
            String email = request.getParameter("email");
            String mobNo = request.getParameter("mobno");
            String password = request.getParameter("password");

            // 2. Package data into the Doctor Entity Object
            // The parameterized constructor we used earlier works here too.
            Doctor d = new Doctor(fullName, dob, qualification, specialist, email, mobNo, password);
            d.setId(id); // CRITICAL: Set the ID for the DAO's WHERE clause
            
            // 3. Instantiate DAO and call the update method
            DoctorDAO dao = new DoctorDAO(DBConnection.getConn());
            boolean f = dao.updateDoctor(d);

            HttpSession session = request.getSession();

            // 4. Handle Response and Redirection
            if (f) {
                session.setAttribute("succMsg", "Doctor Details Updated Successfully");
                // Redirect back to the VIEW page, not the edit form
                response.sendRedirect("admin/admin_view_doctor.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to update doctor details.");
                // Redirect back to the EDIT page with the doctor's ID
                response.sendRedirect("admin/admin_edit_doctor.jsp?id=" + id);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "An unexpected error occurred during processing.");
            // Redirect back to the view page if the ID failed to parse
            response.sendRedirect("admin/admin_view_doctor.jsp");
        }
	}
}