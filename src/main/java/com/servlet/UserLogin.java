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


@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get Form Data
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // 2. Instantiate DAO and call the login method
            UserDAO dao = new UserDAO(DBConnection.getConn());
            
            // 3. Attempt Login: Returns User object if successful, or null if failed
            User user = dao.login(email, password);
            
            // Get the current session
            HttpSession session = request.getSession();
            
            if (user != null) {
                // Success case: Store the User object in the session
                session.setAttribute("userObj", user);
                // Redirect to the user's home page (we'll create this next)
                response.sendRedirect("user_appointment.jsp"); 
            } else {
                // Failure case: User not found or bad credentials
                session.setAttribute("errorMsg", "Invalid email or password");
                // Send user back to the login page
                response.sendRedirect("user_login.jsp"); 
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user_login.jsp"); // Fallback redirect on critical error
        }
    }
}