<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>My Progress | PathCode</title>
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
        
        .navbar-dark .navbar-nav .active > .nav-link {
            color: var(--accent-blue);
            background-color: rgba(56, 189, 248, 0.1);
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
        
        /* Stats Cards */
        .stat-card {
            border-left: 4px solid;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card-primary {
            border-left-color: var(--accent-blue);
        }
        
        .stat-card-success {
            border-left-color: var(--accent-green);
        }
        
        .stat-card-info {
            border-left-color: var(--accent-purple);
        }
        
        .stat-value {
            font-size: 1.75rem;
            font-weight: 700;
            font-family: 'JetBrains Mono', monospace;
        }
        
        /* Badge Styling */
        .badge {
            padding: 0.5em 0.8em;
            font-weight: 500;
            border-radius: 6px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
        }
        
        .badge-easy {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--accent-green);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        .badge-medium {
            background-color: rgba(245, 158, 11, 0.2);
            color: var(--accent-amber);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }
        
        .badge-hard {
            background-color: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.3);
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
        
        /* Table Styling */
        .table {
            color: var(--text-primary);
            margin-bottom: 0;
        }
        
        .table th {
            background-color: var(--bg-secondary);
            color: var(--accent-blue);
            border-bottom: 1px solid var(--border-color);
            font-family: 'JetBrains Mono', monospace;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.75rem;
        }
        
        .table td {
            border-top: 1px solid var(--border-color);
            vertical-align: middle;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(56, 189, 248, 0.05);
        }
        
        /* Button Styling */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.5rem 1rem;
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
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
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
        
        .footer a {
            color: var(--text-secondary) !important;
            transition: all 0.3s ease;
            display: inline-block;
            margin: 0.2rem 0;
            opacity: 0.9;
        }
        
        .footer a:hover {
            color: var(--accent-blue) !important;
            transform: translateX(5px);
            text-decoration: none;
            opacity: 1;
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
                    <%-- <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/list">
                            <i class="fas fa-tachometer-alt"></i> Dashboards
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/learning-path/list">
                            <i class="fas fa-project-diagram"></i> Learning Paths
                        </a>
                    </li> --%>
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/progress/user?userId=${param.userId}">
                            <i class="fas fa-chart-line"></i> My Progress
                        </a>
                    </li>
                    <li class="nav-item">
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

    <!-- Main Content -->
    <div class="container mt-5 animate-fade-in">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-chart-line mr-2"></i>My Progress </h2>
            
        </div>

        <!-- Statistics Cards -->
        <%-- <div class="row mb-4">
            <div class="col-md-4">
                <div class="card stat-card stat-card-primary shadow">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-primary mb-1">Solved Problems</div>
                        <div class="stat-value text-primary">${solvedCount}</div>
                        <div class="text-muted">out of ${totalProblems}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stat-card stat-card-success shadow">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-success mb-1">Success Rate</div>
                        <div class="stat-value text-success">${successRate}%</div>
                        <div class="text-muted">per attempt</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stat-card stat-card-info shadow">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-info mb-1">Avg Time</div>
                        <div class="stat-value text-info">${avgTime}</div>
                        <div class="text-muted">minutes per problem</div>
                    </div>
                </div>
            </div>
        </div> --%>

        <!-- Progress Table -->
        <div class="card shadow">
            <div class="card-header">
                <h6 class="m-0 font-weight-bold"><i class="fas fa-table mr-2"></i>Problem Progress Details</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Problem</th>
                                <th>Difficulty</th>
                                <th>Status</th>
                                <th>Attempts</th>
                                <th>Time Spent</th>
                                <th>Last Attempt</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${progressList}" var="progress">
                            <tr>
                                <td>${progress.title}</td>
                                <td>
                                    <span class="badge ${progress.difficulty == 'Easy' ? 'badge-easy' : 
                                        progress.difficulty == 'Medium' ? 'badge-medium' : 'badge-hard'}">
                                        ${progress.difficulty}
                                    </span>
                                </td>
                                <td>
                                    <span class="progress-status ${progress.solved ? 'status-solved' : 'status-inprogress'}">
                                        <i class="fas ${progress.solved ? 'fa-check-circle' : 'fa-spinner'} mr-2"></i>
                                        ${progress.solved ? 'Solved' : 'In Progress'}
                                    </span>
                                </td>
                                <td>${progress.attempts}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${progress.timeTaken > 9000}"> <!-- 9000 seconds = 150 minutes -->
                                            <fmt:formatNumber value="${progress.timeTaken / 3600}" pattern="#" /> hrs
                                        </c:when>
                                        <c:when test="${progress.timeTaken > 0}">
                                            <fmt:formatNumber value="${progress.timeTaken / 60}" pattern="#" /> mins
                                        </c:when>
                                        <c:otherwise>
                                            0 mins
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${progress.lastAttemptDate}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/problem/view?id=${progress.problemId}" 
                                       class="btn btn-sm btn-primary">
                                        <i class="fas fa-arrow-right"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/progress/view?id=${progress.id}" 
                                           class="btn btn-info" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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