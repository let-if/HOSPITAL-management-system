<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.db.DBConnection"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@include file="all_css.jsp"%>

<%
    // 1. Security Check: Ensures only logged-in users can see this page
    User user = (User) session.getAttribute("userObj");
    if (user == null) {
        session.setAttribute("errorMsg", "Login Required!");
        response.sendRedirect("user_login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Your Appointments</title>
</head>
<body>
    <%@include file="component/navbar.jsp"%>

    <div class="container-fluid p-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Your Booked Appointments</p>
                        
                        <div class="text-end mb-3">
                             <a href="appointment.jsp" class="btn btn-success">Book New Appointment</a>
                        </div>
                        
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Doctor ID</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // 2. DAO Call and Data Retrieval
                                    AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
                                    // Get the list of appointments for the logged-in user
                                    List<Appointment> list = dao.getAllAppointmentByUserId(user.getId());
                                    
                                    // 3. Loop and Display Data
                                    for (Appointment ap : list) {
                                %>
                                <tr>
                                    <td><%=ap.getId()%></td>
                                    <td><%=ap.getAppointDate()%></td>
                                    <td><%=ap.getDoctorId()%></td>
                                    <td><%=ap.getDiseases()%></td>
                                    <td>
                                        <% // Styling status using Bootstrap badges
                                            if ("Pending".equals(ap.getStatus())) { %>
                                            <span class="badge bg-warning text-dark"><%=ap.getStatus()%></span>
                                        <% } else if ("Confirmed".equals(ap.getStatus())) { %>
                                            <span class="badge bg-success"><%=ap.getStatus()%></span>
                                        <% } else { %>
                                            <%=ap.getStatus()%>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                    } // End of for loop
                                %>
                            </tbody>
                        </table>
                        </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>