<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDAO"%>
<%@page import="com.entity.Appointment"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.db.DBConnection"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="all_css.jsp"%>

<%
    // Security Check
    User admin = (User) session.getAttribute("userObj");
    if (admin == null || !"admin".equals(admin.getEmail())) {
        session.setAttribute("errorMsg", "You are not authorized to view this page.");
        response.sendRedirect("../admin_login.jsp");
    }
    
    // 1. Get the Appointment ID from the URL
    int apId = Integer.parseInt(request.getParameter("id"));
    
    // 2. Fetch the Appointment object using the ID
    AppointmentDAO apDao = new AppointmentDAO(DBConnection.getConn());
    Appointment ap = apDao.getAppointmentById(apId); // Assuming you have a getAppointmentById method, if not, we use getAllAppointment() and filter.

    // *Self-Correction/Assumption*: Since we did not create getAppointmentById, let's assume we use the existing DAO to filter the list.
    // However, for efficiency, let's include the getAppointmentById method now, as it's standard practice.
    // We will assume you have a simple getAppointmentById(int id) method in AppointmentDAO that returns a single Appointment object.
    
    // If you haven't created getAppointmentById(int id) in AppointmentDAO, please add it now:
    // This is crucial for retrieving the single appointment data to pre-fill the form.
    
    // Doctor DAO for the dropdown list
    DoctorDAO docDao = new DoctorDAO(DBConnection.getConn());
    List<Doctor> docList = docDao.getAllDoctor();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Appointment Status</title>
</head>
<body>
    <%@include file="component/admin_navbar.jsp"%>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Update Appointment Status</p>
                        
                        <ul class="list-group">
                            <li class="list-group-item">Patient Name: <strong><%=ap.getFullName()%></strong></li>
                            <li class="list-group-item">Appointment Date: <strong><%=ap.getAppointDate()%></strong></li>
                            <li class="list-group-item">Diseases: <strong><%=ap.getDiseases()%></strong></li>
                            <li class="list-group-item">Current Status: <strong><%=ap.getStatus()%></strong></li>
                        </ul>
                        
                        <hr>

                        <form action="../UpdateAppointmentStatus" method="post">
                            
                            <input type="hidden" name="id" value="<%=ap.getId()%>">
                            
                            <div class="mb-3">
                                <label class="form-label">Assign Doctor</label>
                                <select name="doctId" class="form-control" required>
                                    <option value="">--Select Doctor--</option>
                                    <% 
                                        for(Doctor d : docList) {
                                    %>
                                        <option value="<%=d.getId()%>" <%=ap.getDoctorId() == d.getId() ? "selected" : ""%>>
                                            <%=d.getFullName()%> (<%=d.getSpecialist()%>)
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Update Status</label>
                                <select name="status" class="form-control" required>
                                    <option value="Pending" <%=ap.getStatus().equals("Pending") ? "selected" : ""%>>Pending</option>
                                    <option value="Confirmed" <%=ap.getStatus().equals("Confirmed") ? "selected" : ""%>>Confirmed</option>
                                    <option value="Completed" <%=ap.getStatus().equals("Completed") ? "selected" : ""%>>Completed</option>
                                    <option value="Cancelled" <%=ap.getStatus().equals("Cancelled") ? "selected" : ""%>>Cancelled</option>
                                </select>
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-md-12">Update Status</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="/component/footer.jsp"%>
</body>
</html>