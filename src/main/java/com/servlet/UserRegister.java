package com.servlet;

import java.io.IOException;

import com.dao.UserDAO;
import com.db.DBConnection;
import com.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get Form Data (from user_register.jsp using input names)
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // 2. Package data into the User Entity Object
            User u = new User(fullName, email, password);
            
            // 3. Instantiate DAO and call the registration method
            UserDAO dao = new UserDAO(DBConnection.getConn());
            
            // 4. Execute Registration and check the result (true/false)
            boolean f = dao.userRegister(u);
            
            // Get the current session to send messages
            HttpSession session = request.getSession();
            
            if(f) {
                // Success case
                session.setAttribute("succMsg", "Registration Successful");
                // Redirect user to the login page
                response.sendRedirect("user_login.jsp"); 
            } else {
                // Failure case (e.g., database error)
                session.setAttribute("errorMsg", "Something went wrong on server...");
                // Send user back to the registration page
                response.sendRedirect("user_register.jsp"); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}