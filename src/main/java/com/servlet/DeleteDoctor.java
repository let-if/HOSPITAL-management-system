package com.servlet;

import java.io.IOException;

import com.dao.DoctorDAO;
import com.db.DBConnection;
import com.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// IMPORTANT: This annotation maps the URL path 'DeleteDoctor' to this Servlet.
@WebServlet("/DeleteDoctor")
public class DeleteDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the Doctor ID from the URL (Query String)
        int id = Integer.parseInt(request.getParameter("id"));
        
        // 2. Instantiate DAO and call the delete method
        DoctorDAO dao = new DoctorDAO(DBConnection.getConn());
        boolean f = dao.deleteDoctor(id);
        
        HttpSession session = request.getSession();

        // 3. Handle Response and Redirection
        if (f) {
            session.setAttribute("succMsg", "Doctor Deleted Successfully");
        } else {
            session.setAttribute("errorMsg", "Failed to delete doctor.");
        }
        
        // Redirect back to the View Doctors page
        response.sendRedirect("admin/admin_view_doctor.jsp");
	}
}