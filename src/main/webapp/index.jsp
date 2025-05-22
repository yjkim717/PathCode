<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <<<<<<< HEAD -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>PathCode Learning System</title>
    <!-- Use local Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Custom styles -->
    <style>
        :root {
            /* Dark Theme Core Colors */
            --bg-primary: #0F172A;
            --bg-secondary: #1E293B;
            --accent-blue: #38BDF8;
            --accent-purple: #818CF8;
            --accent-green: #10B981;
            --accent-amber: #F59E0B;
            --text-primary: #F1F5F9;
            --text-secondary: #94A3B8;
            --card-bg: rgba(30, 41, 59, 0.8);
            --border-color: rgba(56, 189, 248, 0.2);
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, var(--bg-primary), var(--bg-secondary));
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Animated Background Effects */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(56, 189, 248, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(129, 140, 248, 0.03) 0%, transparent 50%);
        }
        
        /* Code Particles Animation */
        @keyframes float {
            0% { transform: translateY(0) translateX(0) rotate(0); opacity: 0; }
            10% { opacity: 0.5; }
            90% { opacity: 0.5; }
            100% { transform: translateY(-100vh) translateX(20px) rotate(10deg); opacity: 0; }
        }
        
        .code-particle {
            position: fixed;
            color: var(--text-secondary);
            opacity: 0;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.8rem;
            z-index: -1;
            pointer-events: none;
            animation: float 20s linear infinite;
        }
        
        #particle-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }
        
        /* Navbar Styling */
        .navbar {
            background-color: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem;
            z-index: 1030;
        }
        
        .navbar-brand {
            font-family: 'JetBrains Mono', monospace;
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--accent-blue) !important;
            text-shadow: 0 0 10px rgba(56, 189, 248, 0.4);
            letter-spacing: -0.5px;
        }
        
        .navbar-dark .navbar-nav .nav-link {
            color: var(--text-secondary);
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
            padding: 0.5rem 1rem;
            margin: 0 0.2rem;
            border-radius: 4px;
        }
        
        .navbar-dark .navbar-nav .nav-link:hover {
            color: var(--accent-blue);
            background-color: rgba(56, 189, 248, 0.1);
            transform: translateY(-2px);
        }
        
        .navbar-dark .navbar-nav .active > .nav-link {
            color: var(--accent-blue);
            background-color: rgba(56, 189, 248, 0.1);
        }
        
        .navbar-dark .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: var(--accent-blue);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            transition: width 0.3s ease;
        }
        
        .navbar-dark .navbar-nav .nav-link:hover::after,
        .navbar-dark .navbar-nav .active > .nav-link::after {
            width: 60%;
        }
        
        /* Card Styling */
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            overflow: hidden;
            margin-bottom: 24px;
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(56, 189, 248, 0.15);
            border-color: var(--accent-blue);
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .card:hover::before {
            opacity: 1;
        }
        
        .card-header {
            background-color: rgba(15, 23, 42, 0.5);
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            color: var(--accent-blue);
            padding: 1.2rem 1.5rem;
        }
        
        .card-body {
            padding: 1.8rem;
        }
        
        /* Jumbotron Styling */
        .jumbotron {
            background: linear-gradient(135deg, var(--bg-secondary), var(--bg-primary));
            border-bottom: 1px solid var(--border-color);
            border-radius: 0;
            padding: 6rem 2rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
        }
        
        .jumbotron::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQwMCIgaGVpZ2h0PSI4MDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPGcgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj4KICAgIDxwYXRoIGZpbGw9IiMxRTI5M0IiIGQ9Ik0wIDBoMTQwMHY4MDBIMHoiLz4KICAgIDxjaXJjbGUgc3Ryb2tlPSIjMzhCREY4IiBzdHJva2Utd2lkdGg9IjIiIG9wYWNpdHk9Ii4yIiBjeD0iNDAwIiBjeT0iNDAwIiByPSIyMDAiLz4KICAgIDxjaXJjbGUgc3Ryb2tlPSIjMzBCMEQ3IiBzdHJva2Utd2lkdGg9IjIiIG9wYWNpdHk9Ii4yIiBjeD0iNDAwIiBjeT0iNDAwIiByPSIzMDAiLz4KICAgIDxjaXJjbGUgc3Ryb2tlPSIjMzBBNUJCIiBzdHJva2Utd2lkdGg9IjEuNSIgb3BhY2l0eT0iLjIiIGN4PSI0MDAiIGN5PSI0MDAiIHI9IjQwMCIvPgo8L2c+Cjwvc3ZnPg==');
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            opacity: 0.05;
            z-index: 0;
        }
        
        .jumbotron .display-4 {
            font-weight: 700;
            margin-bottom: 1rem;
            font-size: 3rem;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        
        .jumbotron .lead {
            font-size: 1.3rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }
        
        /* Button Styling */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
            overflow: hidden;
            font-family: 'Inter', sans-serif;
        }
        
        .btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0));
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .btn:hover::after {
            opacity: 1;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            border: none;
            box-shadow: 0 4px 10px rgba(56, 189, 248, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(56, 189, 248, 0.4);
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
        }
        
        .btn-secondary {
            background: linear-gradient(90deg, var(--accent-green), #0D9488);
            border: none;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
            color: white;
        }
        
        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(16, 185, 129, 0.4);
            background: linear-gradient(90deg, var(--accent-green), #0D9488);
        }
        
        .btn-light {
            background-color: rgba(241, 245, 249, 0.1);
            color: var(--text-primary);
            border: 1px solid rgba(241, 245, 249, 0.2);
            backdrop-filter: blur(4px);
        }
        
        .btn-light:hover {
            background-color: rgba(241, 245, 249, 0.15);
            color: var(--text-primary);
            transform: translateY(-2px);
        }
        
        /* Feature Styling */
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            display: inline-block;
        }
        
        .feature-icon::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 50px;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.2) 0%, transparent 70%);
            border-radius: 50%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: -1;
        }
        
        /* Badge Styling */
        .badge {
            padding: 0.5em 0.8em;
            font-weight: 500;
            border-radius: 6px;
            margin: 0.2rem;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
        }
        
        .badge-primary {
            background-color: rgba(56, 189, 248, 0.2);
            color: var(--accent-blue);
            border: 1px solid rgba(56, 189, 248, 0.3);
        }
        
        .badge-success {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--accent-green);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        .badge-info {
            background-color: rgba(129, 140, 248, 0.2);
            color: var(--accent-purple);
            border: 1px solid rgba(129, 140, 248, 0.3);
        }
        
        /* Footer Styling */
        .footer {
            background: linear-gradient(to right, var(--bg-primary), var(--bg-secondary));
            backdrop-filter: blur(10px);
            color: var(--text-primary);
            padding: 3rem 0 2rem;
            margin-top: 5rem;
            border-top: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }
        
        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQwMCIgaGVpZ2h0PSI4MDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPGcgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj4KICAgIDxwYXRoIGZpbGw9IiMxRTI5M0IiIGQ9Ik0wIDBoMTQwMHY4MDBIMHoiLz4KICAgIDxjaXJjbGUgc3Ryb2tlPSIjMzhCREY4IiBzdHJva2Utd2lkdGg9IjIiIG9wYWNpdHk9Ii4yIiBjeD0iNDAwIiBjeT0iNDAwIiByPSIyMDAiLz4KICAgIDxjaXJjbGUgc3Ryb2tlPSIjMzBCMEQ3IiBzdHJva2Utd2lkdGg9IjIiIG9wYWNpdHk9Ii4yIiBjeD0iNDAwIiBjeT0iNDAwIiByPSIzMDAiLz4KICAgIDxjaXJjbGUgc3Ryb2tlPSIjMzBBNUJCIiBzdHJva2Utd2lkdGg9IjEuNSIgb3BhY2l0eT0iLjIiIGN4PSI0MDAiIGN5PSI0MDAiIHI9IjQwMCIvPgo8L2c+Cjwvc3ZnPg==');
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            opacity: 0.05;
            z-index: 0;
        }
        
        .footer h4 {
            font-family: 'JetBrains Mono', monospace;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--accent-blue);
            position: relative;
            display: inline-block;
        }
        
        .footer h4::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -8px;
            width: 30px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
        }
        
        .footer a.text-white {
            color: var(--text-secondary) !important;
            transition: all 0.3s ease;
            display: inline-block;
            margin: 0.2rem 0;
            opacity: 0.9;
        }
        
        .footer a.text-white:hover {
            color: var(--accent-blue) !important;
            transform: translateX(5px);
            text-decoration: none;
            opacity: 1;
        }
        
        /* Heading Styles */
        h1, h2, h3, h4, h5, h6 {
            color: var(--text-primary);
        }
        
        h2 {
            font-weight: 700;
            position: relative;
            display: inline-block;
            margin-bottom: 2rem;
        }
        
        h2::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: -10px;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate-fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .animate-pulse {
            animation: pulse 3s infinite;
        }
        
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .jumbotron {
                padding: 3rem 1rem;
            }
            
            .jumbotron .display-4 {
                font-size: 2.2rem;
            }
            
            .card-body {
                padding: 1.2rem;
            }
            
            .feature-icon {
                font-size: 2rem;
            }
        }
        .container-fluid {
            padding-left: 15px;
            padding-right: 15px;
        }
        /* Dropdown Menu Styling */
.dropdown-menu {
    background-color: var(--card-bg);
    border: 1px solid var(--border-color);
    backdrop-filter: blur(10px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    border-radius: 8px;
    overflow: hidden;
    margin-top: 8px;
    z-index: 1050;
}

.dropdown-item {
    color: var(--text-secondary);
    padding: 0.75rem 1.5rem;
    transition: all 0.3s ease;
    position: relative;
}

.dropdown-item:hover, .dropdown-item:focus {
    color: var(--accent-blue);
    background-color: rgba(56, 189, 248, 0.1);
    transform: translateX(5px);
}

.dropdown-item:hover::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    width: 3px;
    height: 100%;
    background: var(--accent-blue);
}

.dropdown-divider {
    border-color: var(--border-color);
    opacity: 0.3;
    margin: 0.25rem 0;
}

    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <!-- Particle Background -->
    <div id="particle-container"></div>
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
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                        <i class="fas fa-home"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/progress/user?userId=${sessionScope.userID}">
                        <i class="fas fa-tachometer-alt"></i> My Progress
                    </a>
                </li>

                <%-- <li class="nav-item">

                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/view?userID=${sessionScope.userID}">

                        <i class="fas fa-tachometer-alt"></i> Dashboards
                    </a>
                </li> --%>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/problem/list">
                        <i class="fas fa-project-diagram"></i> Problems
                    </a>
                </li>
                <%-- <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/recommendation?userID=${sessionScope.userID}">
                        <i class="fas fa-lightbulb"></i> Recommendations
                    </a>
                </li> --%>
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
                    <div class="dropdown-menu dropdown-menu-right animate-fade-in" aria-labelledby="userDropdown">
        				<!-- <div class="dropdown-header px-3 py-2" style="color: var(--accent-blue); font-size: 0.8rem;">
            <i class="fas fa-user-cog mr-2"></i>User Menu
        </div> -->
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">
            <i class="fas fa-sign-out-alt mr-2"></i> Logout
        </a>
    				</div>
                </li>
            </ul>
        </div>
    </div>
    </nav>
<%-- =======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="PathCode Learning System" />
    <jsp:param name="activeMenu" value="home" />
</jsp:include>
>>>>>>> f4ea52b33d00f1c1e2b9b914ebcaa4a40c279360 --%>

    <!-- Hero Section -->
    <div class="jumbotron text-center">
        <div class="container position-relative animate-fade-in">
            <h1 class="display-4">Welcome to PathCode Learning System</h1>
            <p class="lead">A personalized learning platform for coding practice and skill development.</p>
            <a href="#features" class="btn btn-light btn-lg mt-4 animate-pulse">
                <i class="fas fa-arrow-down mr-2"></i> Explore Features
            </a>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container animate-fade-in" id="features">
        <div class="row text-center mb-5">
            <div class="col-md-12">
                <h2 class="mb-4">Our Features</h2>
                <p class="lead" style="color: var(--text-secondary);">Everything you need to enhance your coding journey</p>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="feature-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        <h5 class="card-title" style="color: var(--accent-blue);">Dashboards</h5>
                        <p class="card-text" style="color: var(--text-secondary);">View and manage user dashboards with learning statistics, progress tracking, and performance metrics.</p>
                    <a href="${pageContext.request.contextPath}/dashboard/view" class="btn btn-primary mt-3">
                            <i class="fas fa-arrow-right mr-2"></i> Manage Dashboards
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="feature-icon">
                            <i class="fas fa-project-diagram"></i>
                        </div>
                        <h5 class="card-title" style="color: var(--accent-blue);">Learning Paths</h5>
                        <p class="card-text" style="color: var(--text-secondary);">Create and manage personalized learning paths for users to improve their coding skills.</p>
                        <a href="${pageContext.request.contextPath}/learning-path/list" class="btn btn-primary mt-3">
                            <i class="fas fa-arrow-right mr-2"></i> Manage Learning Paths
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="feature-icon">
                            <i class="fas fa-lightbulb"></i>
                        </div>
                        <h5 class="card-title" style="color: var(--accent-blue);">Recommendations</h5>
                        <p class="card-text" style="color: var(--text-secondary);">Provide tailored problem recommendations based on user performance and preferences.</p>
                        <a href="${pageContext.request.contextPath}/recommendation?userID=${sessionScope.userID}" class="btn btn-primary mt-3">
                            <i class="fas fa-arrow-right mr-2"></i> Manage Recommendations
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-5">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body p-5 text-center">
                        <h3 style="color: var(--accent-blue);">Ready to start your coding journey?</h3>
                        <p class="lead" style="color: var(--text-secondary);">Join thousands of developers who have improved their skills with PathCode.</p>
                        <a href="${pageContext.request.contextPath}/about.jsp" class="btn btn-primary btn-lg mt-4">
                            <i class="fas fa-info-circle"></i> About us
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container position-relative">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4><i class="fas fa-code"></i> PathCode</h4>
                    <p style="color: var(--text-secondary);">A personalized learning platform for coding practice and skill development.</p>
                    <p style="color: var(--text-secondary);">Helping developers master programming one step at a time.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4>Quick Links</h4>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white"><i class="fas fa-angle-right mr-2"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/progress/list" class="text-white"><i class="fas fa-angle-right mr-2"></i> User Progress</a></li>
                        <li><a href="${pageContext.request.contextPath}/problem/list" class="text-white"><i class="fas fa-angle-right mr-2"></i> Problems</a></li>
                        <li><a href="${pageContext.request.contextPath}/learning-path/list" class="text-white"><i class="fas fa-angle-right mr-2"></i> Learning Paths</a></li>
                        <li><a href="${pageContext.request.contextPath}/recommendation?userID=${sessionScope.userID}" class="text-white"><i class="fas fa-angle-right mr-2"></i> Recommendations</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4>Connect With Us</h4>
                <div class="social-icons">
                    <a href="#" class="text-white mr-3"><i class="fab fa-github fa-2x"></i></a>
                    <a href="#" class="text-white mr-3"><i class="fab fa-twitter fa-2x"></i></a>
                    <a href="#" class="text-white mr-3"><i class="fab fa-linkedin fa-2x"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-discord fa-2x"></i></a>
                </div>
                <p class="mt-3" style="color: var(--text-secondary);">Follow us for updates and coding tips!</p>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-md-12">
                <p class="mb-0" style="color: var(--text-secondary);">&copy; 2023 PathCode Learning System. All rights reserved.</p>
            </div>
        </div>
        </div>
    </footer>

<!-- <<<<<<< HEAD -->
    <!-- Use local Bootstrap JS files -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    
    <!-- Particle Animation Script -->
<!-- =======
JavaScript Dependencies
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

Particles Animation
>>>>>>> f4ea52b33d00f1c1e2b9b914ebcaa4a40c279360 -->
    <script>
        // Create code particles
    function createParticles() {
        const container = document.getElementById('particle-container');
        const codeSnippets = [
            'function()', 'if(x > y)', 'return true;', 'const data = [];', 
            'for(i=0; i<n; i++)', 'while(running)', '{ code }', 'await fetch()',
            '#include <iostream>', 'import java.util.*', 'class Main', 'public static void',
            'SELECT * FROM', 'npm install', 'git commit', 'docker run'
        ];
        
        for (let i = 0; i < 20; i++) {
            const particle = document.createElement('div');
            particle.classList.add('code-particle');
            particle.textContent = codeSnippets[Math.floor(Math.random() * codeSnippets.length)];
            particle.style.left = Math.random() * 100 + 'vw';
            particle.style.top = Math.random() * 100 + 'vh';
            particle.style.animationDuration = (Math.random() * 20 + 10) + 's';
            particle.style.animationDelay = (Math.random() * 5) + 's';
            container.appendChild(particle);
        }
    }
    
    // Initialize particles on page load
    document.addEventListener('DOMContentLoaded', function() {
        createParticles();
        });
    </script>

    <script>
$(document).ready(function(){
    // Initialize dropdowns
    $('.dropdown-toggle').dropdown();
    
    // Custom dropdown hover behavior (optional)
    /* $('.nav-item.dropdown').hover(function() {
        $(this).addClass('show');
        $(this).find('.dropdown-menu').addClass('show');
    }, function() {
        $(this).removeClass('show');
        $(this).find('.dropdown-menu').removeClass('show');
    }); */
});
</script>

</body>
</html>

