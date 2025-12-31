<%@page import="com.db.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>User Register</title>
    <%@include file="all_css.jsp" %>
</head>
<body class="bg-light">
    
    <%@include file="component/navbar.jsp" %>
    
    <div class="container p-5">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card shadow">
                    <div class="card-body">
                        <p class="fs-4 text-center">User Register</p>
                        
                        <form action="UserRegister" method="post">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label> 
                                <input type="text" required class="form-control" name="fullname">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Email Address</label> 
                                <input type="email" required class="form-control" name="email">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label> 
                                <input type="password" required class="form-control" name="password">
                            </div>

                            <button type="submit" class="btn btn-primary col-md-12">Register</button>
                            <div class="text-center mt-2">
                                <a href="user_login.jsp">Already have an account? Login</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>