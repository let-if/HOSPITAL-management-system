<%@page import="com.entity.Doctor"%>
<%@page import="com.entity.Appointment"%>
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
        return; // Stop processing the page
    }
    
    // 1. Get the Appointment ID from the URL
    int apId = Integer.parseInt(request.getParameter("id"));
    
    // 2. Fetch the Appointment object using the ID
    AppointmentDAO apDao = new AppointmentDAO(DBConnection.getConn());
    Appointment ap = apDao.getAppointmentById(apId); 
    
    // CRITICAL SECURITY CHECK: Ensure the appointment is assigned to this doctor
    if (ap == null || ap.getDoctorId() != d.getId()) {
        session.setAttribute("errorMsg", "Access Denied: Appointment not assigned to you.");
        response.sendRedirect("doctor_dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Appointment</title>
</head>
<body>
    <%@include file="component/doctor_navbar.jsp"%>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Update Appointment Status</p>
                        
                        <%
                            String errorMsg = (String) session.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                            <p class="text-center text-danger"><%=errorMsg%></p>
                        <%
                                session.removeAttribute("errorMsg");
                            }
                        %>

                        <ul class="list-group">
                            <li class="list-group-item">Patient Name: <strong><%=ap.getFullName()%></strong></li>
                            <li class="list-group-item">Appointment Date: <strong><%=ap.getAppointDate()%></strong></li>
                            <li class="list-group-item">Diseases: <strong><%=ap.getDiseases()%></strong></li>
                            <li class="list-group-item">Current Status: <strong><%=ap.getStatus()%></strong></li>
                        </ul>
                        
                        <hr>

                        <form action="../DoctorUpdateStatus" method="post">
                            
                            <input type="hidden" name="id" value="<%=ap.getId()%>">
                            <input type="hidden" name="doctId" value="<%=d.getId()%>"> 
                            
                            <div class="mb-3">
                                <label class="form-label">Update Status</label>
                                <select name="status" class="form-control" required>
                                    <option value="Pending" <%=ap.getStatus().equals("Pending") ? "selected" : ""%>>Pending</option>
                                    <option value="Confirmed" <%=ap.getStatus().equals("Confirmed") ? "selected" : ""%>>Confirmed</option>
                                    <option value="Completed" <%=ap.getStatus().equals("Completed") ? "selected" : ""%>>Completed</option>
                                    <option value="Cancelled" <%=ap.getStatus().equals("Cancelled") ? "selected" : ""%>>Cancelled</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Doctor Notes (Optional)</label>
                                <textarea name="comment" rows="3" class="form-control"></textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-md-12">Update Status</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp"%>
</body>
</html>