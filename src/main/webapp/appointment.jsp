<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@include file="all_css.jsp"%>

<%
    // Security Check: If the user is not logged in, redirect them to the login page.
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
    <title>Book Appointment</title>
</head>
<body>
    <%@include file="component/navbar.jsp"%>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Book Appointment</p>
                        
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
                        
                        <form action="AddAppointment" method="post">
                            <input type="hidden" name="userid" value="<%=user.getId()%>">
                            
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullname" value="<%=user.getFullName()%>" class="form-control" required readonly>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <select name="gender" class="form-control" required>
                                    <option value="">--Select--</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Age</label>
                                <input type="number" name="age" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Appointment Date</label>
                                <input type="date" name="appoint_date" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" value="<%=user.getEmail()%>" class="form-control" required readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Phone No</label>
                                <input type="tel" name="phno" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Diseases / Symptoms</label>
                                <input type="text" name="diseases" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Select Doctor</label>
                                <select name="doctor" class="form-control" required>
                                    <option value="">--Select--</option>
                                    <option value="1">Dr. John Doe (General Physician)</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Full Address</label>
                                <textarea rows="3" name="address" class="form-control" required></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary col-md-12">Submit</button>
                        </form>
                        </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>