<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>User Login</title>
    <%@include file="all_css.jsp" %>
</head>
<body class="bg-light">
    
    <!-- <%@include file="component/navbar.jsp" %> -->
    
    <div class="container p-5">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card shadow">
                    <div class="card-body">
                        <p class="fs-4 text-center">User Login</p>
                        
                        <c:if test="${not empty succMsg}">
                            <p class="text-center text-success fs-5">${succMsg}</p>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        
                        <c:if test="${not empty errorMsg}">
                            <p class="text-center text-danger fs-5">${errorMsg}</p>
                            <c:remove var="errorMsg" scope="session"/>
                        </c:if>
                        
                        <form action="UserLogin" method="post">
                            <div class="mb-3">
                                <label class="form-label">Email Address</label> 
                                <input type="email" required class="form-control" name="email">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label> 
                                <input type="password" required class="form-control" name="password">
                            </div>

                            <button type="submit" class="btn btn-primary col-md-12">Login</button>
                            <div class="text-center mt-2">
                                <a href="user_register.jsp">Don't have an account? Register</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>