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

@WebServlet("/DoctorLogin")
public class DoctorLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession();
        
        // 1. Authenticate using DoctorDAO
        DoctorDAO dao = new DoctorDAO(DBConnection.getConn());
        Doctor doctor = dao.loginDoctor(email, password);

        // 2. Handle Authentication Result
        if (doctor != null) {
            // Login Success: Store doctor object in session
            session.setAttribute("doctObj", doctor);
            // Redirect to the Doctor Dashboard (to be created next)
            response.sendRedirect("doctor/doctor_dashboard.jsp"); 
        } else {
            // Login Failure
            session.setAttribute("errorMsg", "Invalid Email or Password");
            response.sendRedirect("doctor_login.jsp");
        }
	}
}