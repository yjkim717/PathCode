<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Progress Details | PathCode</title>
    <!-- Use local Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
        
        /* Navbar Styling */
        .navbar {
            background-color: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem;
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
        
        /* Card Styling */
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            overflow: hidden;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(56, 189, 248, 0.15);
            border-color: var(--accent-blue);
        }
        
        .card-header {
            background-color: rgba(15, 23, 42, 0.5);
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            color: var(--accent-blue);
            padding: 1.2rem 1.5rem;
        }
        
        /* Detail Styling */
        .detail-label {
            font-weight: 600;
            color: var(--accent-blue);
            min-width: 150px;
            display: inline-block;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.9rem;
        }
        
        .detail-value {
            color: var(--text-primary);
            font-weight: 500;
        }
        
        /* Progress Status */
        .progress-status {
            display: inline-block;
            padding: 0.35em 0.65em;
            border-radius: 6px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .status-solved {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--accent-green);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        .status-inprogress {
            background-color: rgba(23, 162, 184, 0.2);
            color: #17a2b8;
            border: 1px solid rgba(23, 162, 184, 0.3);
        }
        
        /* Button Styling */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            font-family: 'Inter', sans-serif;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            border: none;
            box-shadow: 0 4px 10px rgba(56, 189, 248, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(56, 189, 248, 0.4);
        }
        
        .btn-success {
            background: linear-gradient(90deg, var(--accent-green), #0D9488);
            border: none;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(16, 185, 129, 0.4);
        }
        
        .btn-warning {
            background: linear-gradient(90deg, var(--accent-amber), #D97706);
            border: none;
            box-shadow: 0 4px 10px rgba(245, 158, 11, 0.3);
        }
        
        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(245, 158, 11, 0.4);
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
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate-fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
    </style>
</head>
<body>
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
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                   
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/progress/user?userId=${progress.userId}">
                            <i class="fas fa-chart-line"></i> My Progress
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/problem/list">
                            <i class="fas fa-chart-line"></i> Problems
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

    <!-- Main Content -->
    <div class="container mt-5 animate-fade-in">
        <div class="card shadow">
            <div class="card-header">
                <h4 class="m-0"><i class="fas fa-info-circle mr-2"></i>Progress Details</h4>
            </div>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <p class="mb-3">
                            <span class="detail-label"><i class="fas fa-user mr-2"></i>User ID:</span>
                            <span class="detail-value">${progress.userId}</span>
                        </p>
                        
                        <p class="mb-3">
                            <span class="detail-label"><i class="fas fa-tasks mr-2"></i>Problem:</span>
                            <span class="detail-value">${progress.title}</span>
                        </p>
                        
                        <p class="mb-3">
                            <span class="detail-label"><i class="fas fa-check-circle mr-2"></i>Status:</span>
                            <span class="progress-status ${progress.solved ? 'status-solved' : 'status-inprogress'}">
                                <i class="fas ${progress.solved ? 'fa-check-circle' : 'fa-spinner'} mr-1"></i>
                                ${progress.solved ? 'Solved' : 'In Progress'}
                            </span>
                        </p>
                    </div>
                    
                    <div class="col-md-6">
                        <p class="mb-3">
                            <span class="detail-label"><i class="fas fa-redo mr-2"></i>Attempts:</span>
                            <span class="detail-value">${progress.attempts}</span>
                        </p>
                        
                        <p class="mb-3">
                            <span class="detail-label"><i class="fas fa-clock mr-2"></i>Time Taken:</span>
                            <span class="detail-value">${progress.timeTaken} minutes</span>
                        </p>
                        
                        <p class="mb-3">
                            <span class="detail-label"><i class="fas fa-calendar-alt mr-2"></i>Last Attempt:</span>
                            <span class="detail-value">${progress.lastAttemptDate}</span>
                        </p>
                    </div>
                </div>
                
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/progress/user?userId=${progress.userId}" 
                       class="btn btn-primary mr-3">
                        <i class="fas fa-arrow-left mr-2"></i> Back to My Progress
                    </a>
                    
                    <c:choose>
                        <c:when test="${progress.solved}">
                            <a href="${pageContext.request.contextPath}/progress/update?id=${progress.id}&status=inprogress" 
                               class="btn btn-warning">
                                <i class="fas fa-undo mr-2"></i> Mark as In Progress
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/progress/update?id=${progress.id}&status=solved" 
                               class="btn btn-success">
                                <i class="fas fa-check mr-2"></i> Mark as Solved
                            </a>
                        </c:otherwise>
                    </c:choose>
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
                    <p>A personalized learning platform for coding practice and skill development.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4>Quick Links</h4>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-angle-right mr-2"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/dashboard/list"><i class="fas fa-angle-right mr-2"></i> Dashboards</a></li>
                        <li><a href="${pageContext.request.contextPath}/learning-path/list"><i class="fas fa-angle-right mr-2"></i> Learning Paths</a></li>
                        <li><a href="${pageContext.request.contextPath}/recommendation/list"><i class="fas fa-angle-right mr-2"></i> Recommendations</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4>Connect With Us</h4>
                    <div class="mt-3" style="display: flex; justify-content: center; gap: 15px;">
                        <a href="#" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-github"></i>
                        </a>
                        <a href="#" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-linkedin"></i>
                        </a>
                    </div>
                </div>
            </div>
            <hr style="border-color: rgba(56, 189, 248, 0.2); margin: 2rem 0;">
            <p>&copy; 2025 PathCode Learning System. All rights reserved.</p>
        </div>
    </footer>

    <!-- Use local Bootstrap JS files -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>