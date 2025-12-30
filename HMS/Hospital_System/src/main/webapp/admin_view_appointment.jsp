<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.db.DBConnection"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="all_css.jsp"%>

<%
    // Security Check: Only allow the Admin to view this page.
    User admin = (User) session.getAttribute("userObj");
    if (admin == null || !"admin".equals(admin.getEmail())) {
        session.setAttribute("errorMsg", "You are not authorized to view this page.");
        response.sendRedirect("../admin_login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>All Appointments - Admin</title>
</head>
<body>
    <%@include file="component/admin_navbar.jsp"%>

    <div class="container-fluid p-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">All Patient Appointments</p>
                        
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Patient Name</th>
                                    <th scope="col">Gender/Age</th>
                                    <th scope="col">Appointment Date</th>
                                    <th scope="col">Doctor ID</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // 1. Instantiate DAO and call the new method
                                    AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
                                    List<Appointment> list = dao.getAllAppointment();
                                    
                                    // 2. Loop and display data
                                    for (Appointment ap : list) {
                                %>
                                <tr>
                                    <td><%=ap.getId()%></td>
                                    <td><%=ap.getFullName()%></td>
                                    <td><%=ap.getGender()%>/<%=ap.getAge()%></td>
                                    <td><%=ap.getAppointDate()%></td>
                                    <td><%=ap.getDoctorId()%></td>
                                    <td><%=ap.getDiseases()%></td>
                                    <td>
                                        <% // Display status with badges
                                            if ("Pending".equals(ap.getStatus())) { %>
                                            <span class="badge bg-warning text-dark"><%=ap.getStatus()%></span>
                                        <% } else if ("Confirmed".equals(ap.getStatus())) { %>
                                            <span class="badge bg-success"><%=ap.getStatus()%></span>
                                        <% } else { %>
                                            <%=ap.getStatus()%>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="admin_edit_appointment.jsp?id=<%=ap.getId()%>" class="btn btn-sm btn-info">Update Status</a>
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

    <%@include file="../component/footer.jsp"%>
</body>
</html>