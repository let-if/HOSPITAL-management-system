<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    User admin = (User) session.getAttribute("userObj");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-hospital"></i> E-Healthcare
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="admin_index.jsp"><i class="fas fa-home"></i> HOME</a>
                </li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-md"></i> DOCTOR
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="add_doctor.jsp">Add Doctor</a></li>
                        <li><a class="dropdown-item" href="admin_view_doctor.jsp">View Doctors</a></li>
                    </ul>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="add_specialist.jsp"><i class="fas fa-hands-helping"></i> SPECIALIST</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="admin_view_appointment.jsp"><i class="fas fa-calendar-check"></i> APPOINTMENT</a>
                </li>

            </ul>
            
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-user-circle"></i> Admin (<%=admin.getFullName()%>)</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="../userLogout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>