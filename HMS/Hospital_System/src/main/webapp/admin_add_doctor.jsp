<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="all_css.jsp"%>

<%
    // Security Check: Only allow the Admin to view this page.
    User admin = (User) session.getAttribute("userObj");
    if (admin == null || !"admin".equals(admin.getEmail())) {
        session.setAttribute("errorMsg", "You are not authorized to view this page.");
        response.sendRedirect("../admin_login.jsp"); // Redirect to admin login if not admin
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Doctor - Admin</title>
</head>
<body>
    <%@include file="component/admin_navbar.jsp" %>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Add Doctor</p>
                        
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

                        <form action="../AddDoctor" method="post">
                            
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullname" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">DOB</label>
                                <input type="date" name="dob" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Qualification</label>
                                <input type="text" name="qualification" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Specialist</label>
                                <select name="specialist" class="form-control" required>
                                    <option value="">--Select--</option>
                                    <option value="General Physician">General Physician</option>
                                    <option value="Dentist">Dentist</option>
                                    <option value="Cardiologist">Cardiologist</option>
                                    <option value="Neurologist">Neurologist</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mobile No</label>
                                <input type="tel" name="mobno" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-md-12">Add Doctor</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="/component/footer.jsp"%>
</body>
</html>