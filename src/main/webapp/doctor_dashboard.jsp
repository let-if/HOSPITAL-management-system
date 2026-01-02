<%@page import="com.entity.Doctor"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="all_css.jsp"%>

<%
    // Security Check: Ensures only a logged-in doctor can see this page
    Doctor d = (Doctor) session.getAttribute("doctObj");
    if (d == null) {
        session.setAttribute("errorMsg", "Doctor Login Required!");
        response.sendRedirect("../doctor_login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Doctor Dashboard</title>
</head>
<body>
    <%@include file="component/doctor_navbar.jsp"%>

    <div class="container-fluid p-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">
                            Welcome, Dr. <%=d.getFullName()%>
                        </p>
                        <p class="text-center text-muted">Your Assigned Appointments</p>
                        
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Patient Name</th>
                                    <th scope="col">Gender/Age</th>
                                    <th scope="col">Appointment Date</th>
                                    <th scope="col">Contact</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // 1. Instantiate DAO
                                    AppointmentDAO apDao = new AppointmentDAO(DBConnect.getConn());
                                    
                                    // 2. Call the new method to get appointments for the logged-in doctor
                                    List<Appointment> list = apDao.getAllAppointmentByDoctorId(d.getId());
                                    
                                    // 3. Loop and display data
                                    for (Appointment ap : list) {
                                %>
                                <tr>
                                    <td><%=ap.getId()%></td>
                                    <td><%=ap.getFullName()%></td>
                                    <td><%=ap.getGender()%>/<%=ap.getAge()%></td>
                                    <td><%=ap.getAppointDate()%></td>
                                    <td><%=ap.getPhNo()%></td>
                                    <td><%=ap.getDiseases()%></td>
                                    <td>
                                        <span class="badge bg-info text-dark"><%=ap.getStatus()%></span>
                                    </td>
                                    <td>
                                        <a href="doctor_edit_appointment.jsp?id=<%=ap.getId()%>" class="btn btn-sm btn-success">Update Status</a>
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