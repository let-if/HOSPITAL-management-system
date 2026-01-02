<%@page import="com.dao.DoctorDAO"%>
<%@page import="com.db.DBConnection"%>
<%@page import="com.entity.Doctor"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="all_css.jsp"%>

<%
    // Security Check (same as view page)
    User admin = (User) session.getAttribute("userObj");
    if (admin == null || !"admin".equals(admin.getEmail())) {
        session.setAttribute("errorMsg", "You are not authorized to view this page.");
        response.sendRedirect("../admin_login.jsp");
    }
    
    // 1. Get the Doctor ID from the URL
    int id = Integer.parseInt(request.getParameter("id"));
    
    // 2. Fetch the Doctor object using the ID
    DoctorDAO dao = new DoctorDAO(DBConnection.getConn());
    Doctor d = dao.getDoctorById(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Doctor - <%=d.getFullName()%></title>
</head>
<body>
    <%@include file="component/admin_navbar.jsp"%>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Edit Doctor</p>
                        
                        <%
                            String succMsg = (String) session.getAttribute("succMsg");
                            if (succMsg != null) {
                        %>
                            <p class="text-center text-success fs-5"><%=succMsg%></p>
                        <%
                                session.removeAttribute("succMsg");
                            }

                            String errorMsg = (String) session.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                            <p class="text-center text-danger fs-5"><%=errorMsg%></p>
                        <%
                                session.removeAttribute("errorMsg");
                            }
                        %>

                        <form action="../EditDoctor" method="post">
                            
                            <input type="hidden" name="id" value="<%=d.getId()%>">
                            
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullname" class="form-control" 
                                    value="<%=d.getFullName()%>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">DOB</label>
                                <input type="date" name="dob" class="form-control" 
                                    value="<%=d.getDob()%>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Qualification</label>
                                <input type="text" name="qualification" class="form-control" 
                                    value="<%=d.getQualification()%>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Specialist</label>
                                <select name="specialist" class="form-control" required>
                                    <option value="General Physician" <%=d.getSpecialist().equals("General Physician") ? "selected" : ""%>>General Physician</option>
                                    <option value="Dentist" <%=d.getSpecialist().equals("Dentist") ? "selected" : ""%>>Dentist</option>
                                    <option value="Cardiologist" <%=d.getSpecialist().equals("Cardiologist") ? "selected" : ""%>>Cardiologist</option>
                                    <option value="Neurologist" <%=d.getSpecialist().equals("Neurologist") ? "selected" : ""%>>Neurologist</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" 
                                    value="<%=d.getEmail()%>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mobile No</label>
                                <input type="tel" name="mobno" class="form-control" 
                                    value="<%=d.getMobNo()%>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" 
                                    value="<%=d.getPassword()%>" required>
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-md-12">Update Doctor</button>
                            <a href="admin_view_doctor.jsp" class="btn btn-danger col-md-12 mt-2">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="/component/footer.jsp"%>
</body>
</html>