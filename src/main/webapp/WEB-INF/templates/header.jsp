<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${param.pageTitle} - PathCode Learning System</title>
    
    <!-- Bootstrap and Base CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    
    <!-- Dark Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css">
    
    <!-- Custom page level styles -->
    <c:if test="${not empty param.customCss}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${param.customCss}">
    </c:if>
    
    <!-- Additional custom styles from the including page -->
    <c:if test="${not empty param.customStyles}">
        <style>
            /* Custom styles */
            ${param.customStyles}
        </style>
    </c:if>
</head>
<body>
    <!-- Particle Background Container -->
    <div id="particle-container"></div>
    
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                <i class="fas fa-code"></i> PathCode
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item ${param.activeMenu == 'home' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    
                    <li class="nav-item ${param.activeMenu == 'progress' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/progress/user?userId=${sessionScope.userID}">
                            <i class="fas fa-tachometer-alt"></i> My Progress
                        </a>
                    </li>
                    
                    <%-- <li class="nav-item ${param.activeMenu == 'dashboard' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/view">
                            <i class="fas fa-chart-line"></i> Dashboards
                        </a>
                    </li> --%>
                    
                    <li class="nav-item ${param.activeMenu == 'problem' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/problem/list">
                            <i class="fas fa-project-diagram"></i> Problems
                        </a>
                    </li>
                    <!-- User Info Section -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user"></i>
                            <%
                                String username = (String) session.getAttribute("username");
                                if (username != null) {
                            %>
                                <%= username %>
                            <%
                                } else {
                            %>
                                Guest
                            <%
                                }
                            %>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Logout</a>
                        </div>
                    </li>
                    
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content Container -->
    <div class="container mt-4 animate-fade-in">
        <!-- Success and Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle mr-2"></i> ${successMessage}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle mr-2"></i> ${errorMessage}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
    </div>
</body>
</html> 