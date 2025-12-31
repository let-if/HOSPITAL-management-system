<%@page import="com.entity.Doctor"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="all_css.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Doctor Login</title>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp"%>

    <div class="container p-5">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <p class="fs-4 text-center">Doctor Login</p>
                        
                        <%
                            String errorMsg = (String) session.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                            <p class="text-center text-danger"><%=errorMsg%></p>
                        <%
                                session.removeAttribute("errorMsg");
                            }
                        %>

                        <form action="DoctorLogin" method="post">
                            
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input required name="email" type="email" class="form-control">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input required name="password" type="password" class="form-control">
                            </div>
                            
                            <button type="submit" class="btn btn-primary col-md-12">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>