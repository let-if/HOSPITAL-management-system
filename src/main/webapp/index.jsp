<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>E-Healthcare Home</title>
    <%@include file="all_css.jsp" %>
    <style type="text/css">
        .paint-card {
            box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <%@include file="component/navbar.jsp" %>
    
    <div class="container p-5">
        <div class="row">
            <div class="col-md-6 p-5">
                <img alt="" src="img/hp1.jpg" style="width: 400px; height: 300px">
            </div>
            
            <div class="col-md-6 p-5">
                <h1 class="text-center p-3">Welcome to E-Healthcare Hospital System</h1>
                <p>
                    Your reliable partner in health management. Book appointments, manage
                    your profile, and connect with our specialized doctors easily.
                    Our mission is to provide efficient and accessible healthcare for
                    everyone.
                </p>
                <a href="user_register.jsp" class="btn btn-info text-white">Register Now</a>
            </div>
        </div>
    </div>
    
    <div class="container-fluid fixed-bottom bg-info p-3">
        <h5 class="text-center text-white">Hospital Management System</h5>
    </div>

</body>
</html>