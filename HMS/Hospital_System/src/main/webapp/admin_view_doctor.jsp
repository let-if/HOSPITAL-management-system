<%@page import="com.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.DoctorDAO"%>
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
<title>View Doctors - Admin</title>
</head>
<body>
    <%@include file="component/admin_navbar.jsp"%>

    <div class="container-fluid p-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Doctor Details</p>
                        
                        <%
                            String succMsg = (String) session.getAttribute("succMsg");
                            if (succMsg != null) {
                        %>
                            <p class="text-center text-success fs-5"><%=succMsg%></p>
                        <%
                                session.removeAttribute("succMsg");
                            }
                        %>

                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Full Name</th>
                                    <th scope="col">DOB</th>
                                    <th scope="col">Qualification</th>
                                    <th scope="col">Specialist</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Mobile No</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // 1. Instantiate DAO and get connection
                                    DoctorDAO dao = new DoctorDAO(DBConnection.getConn());
                                    
                                    // 2. Call the new method to retrieve all doctors
                                    List<Doctor> list = dao.getAllDoctor();
                                    
                                    // 3. Loop and display data in table rows
                                    for (Doctor d : list) {
                                %>
                                <tr>
                                    <td><%=d.getId()%></td>
                                    <td><%=d.getFullName()%></td>
                                    <td><%=d.getDob()%></td>
                                    <td><%=d.getQualification()%></td>
                                    <td><%=d.getSpecialist()%></td>
                                    <td><%=d.getEmail()%></td>
                                    <td><%=d.getMobNo()%></td>
                                    <td>
                                        <a href="admin_edit_doctor.jsp?id=<%=d.getId()%>" class="btn btn-sm btn-primary">Edit</a>
                                        <a href="../DeleteDoctor?id=<%=d.getId()%>" class="btn btn-sm btn-danger">Delete</a>
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