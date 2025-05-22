<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>404 Not Found - PathCode Learning System</title>
    
    <!-- Bootstrap and Base CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    
    <!-- Dark Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css">
    
    <style>
        .error-container {
            min-height: 80vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        
        .error-code {
            font-size: 8rem;
            font-weight: 700;
            margin-bottom: 0;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1;
        }
        
        .error-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            color: var(--accent-blue);
        }
    </style>
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
        </div>
    </nav>
    
    <div class="container error-container animate-fade-in">
        <div class="error-icon">
            <i class="fas fa-search"></i>
        </div>
        <h1 class="error-code">404</h1>
        <h2 class="mb-4">Page Not Found</h2>
        <p class="lead text-secondary mb-4">The page you are looking for does not exist or has been moved.</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary btn-lg">
            <i class="fas fa-home mr-2"></i> Return to Home
        </a>
    </div>
    
    <!-- Required Scripts -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/particles.js"></script>
</body>
</html> 