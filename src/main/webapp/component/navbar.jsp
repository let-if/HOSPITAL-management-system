<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp"><i class="fas fa-hospital"></i> Hospital System</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-brand">
          <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
        </li>
      </ul>

      <form class="d-flex">
        <%-- Logic to show Login/Register if user is NOT logged in --%>
        <c:if test="${empty userObj}">
            <a href="user_login.jsp" class="btn btn-light ms-2">Login</a>
            <a href="user_register.jsp" class="btn btn-light ms-2">Register</a>
        </c:if>

        <%-- Logic to show User Name and Logout if user IS logged in --%>
        <c:if test="${not empty userObj}">
            <div class="dropdown">
              <button class="btn btn-light dropdown-toggle ms-2" type="button" data-bs-toggle="dropdown">
                <i class="fas fa-user-circle"></i> ${userObj.name}
              </button>
              <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="change_password.jsp">Change Password</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="Logout">Logout</a></li>
              </ul>
            </div>
        </c:if>
      </form>
    </div>
  </div>
</nav>