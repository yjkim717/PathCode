<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>User Progress Tracking | PathCode</title>
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
        
        .card-header {
            background-color: rgba(15, 23, 42, 0.5);
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            color: var(--accent-blue);
            padding: 1.2rem 1.5rem;
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
        
        .status-notstarted {
            background-color: rgba(108, 117, 125, 0.2);
            color: #6c757d;
            border: 1px solid rgba(108, 117, 125, 0.3);
        }
        
        /* Button Styling */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            font-family: 'Inter', sans-serif;
            border: none;
        }
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .btn-group-sm > .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .btn-outline-primary {
            color: var(--accent-blue);
            border: 1px solid var(--accent-blue);
            background-color: transparent;
        }
        
        .btn-outline-primary:hover {
            background-color: rgba(56, 189, 248, 0.1);
            color: var(--accent-blue);
        }
        
        .btn-info {
            background-color: rgba(23, 162, 184, 0.2);
            color: #17a2b8;
            border: 1px solid rgba(23, 162, 184, 0.3);
        }
        
        .btn-info:hover {
            background-color: rgba(23, 162, 184, 0.3);
            color: #17a2b8;
        }
        
        .btn-success {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--accent-green);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        .btn-success:hover {
            background-color: rgba(16, 185, 129, 0.3);
            color: var(--accent-green);
        }
        
        /* Heading Styles */
        h2 {
            font-weight: 700;
            position: relative;
            display: inline-block;
            margin-bottom: 1.5rem;
        }
        
        h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -10px;
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
        }
        
        /* Footer Styling */
        .footer {
            background: linear-gradient(to right, var(--bg-primary), var(--bg-secondary));
            backdrop-filter: blur(10px);
            color: var(--text-primary);
            padding: 2rem 0;
            margin-top: 3rem;
            border-top: 1px solid var(--border-color);
        }
        
        .footer p {
            color: var(--text-secondary);
            margin-bottom: 0;
        }
        
        /* Empty State */
        .empty-state {
            padding: 3rem 0;
            text-align: center;
        }
        
        .empty-state i {
            font-size: 3rem;
            color: var(--text-secondary);
            margin-bottom: 1rem;
        }
        
        .empty-state h5 {
            color: var(--text-primary);
        }
        
        .empty-state p {
            color: var(--text-secondary);
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/progress/list">
                            <i class="fas fa-tachometer-alt"></i> User Progress
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/problem/list">
                            <i class="fas fa-project-diagram"></i> Problems
                        </a>
                    </li>
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

    <div class="container mt-5 animate-fade-in">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-tasks mr-2"></i>User Progress Tracking</h2>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/progress/user?userId=1" class="btn btn-outline-primary">
                    <i class="fas fa-user mr-2"></i>My Progress
                </a>
            </div>
        </div>

        <div class="card shadow">
            <div class="card-header">
                <i class="fas fa-table mr-2"></i>Progress Records
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Problem</th>
                                <th>Difficulty</th>
                                <th>Status</th>
                                <th>Attempts</th>
                                <th>Last Attempt</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${progressList}" var="progress">
                            <tr>
                                <td>User #${progress.userId}</td>
                                <td>${progress.title}</td>
                                <td>
                                    <span class="badge badge-easy">Easy</span>
                                </td>
                                <td>
                                    <span class="progress-status ${progress.solved ? 'status-solved' : 'status-inprogress'}">
                                        ${progress.solved ? 'Solved' : 'In Progress'}
                                    </span>
                                </td>
                                <td>${progress.attempts}</td>
                                <td>${progress.lastAttemptDate}</td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="${pageContext.request.contextPath}/progress/view?id=${progress.id}" 
                                           class="btn btn-info" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/progress/update?id=${progress.id}&status=solved" 
                                           class="btn btn-success" title="Mark as Solved">
                                            <i class="fas fa-check"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <c:if test="${empty progressList}">
                        <div class="empty-state">
                            <i class="fas fa-clipboard-list fa-3x"></i>
                            <h5 class="mt-3">No progress records found</h5>
                            <p>Start solving problems to track your progress.</p>
                        </div>
                    </c:if>
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
                    <p>Helping developers master programming one step at a time.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4>Quick Links</h4>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-angle-right mr-2"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/dashboard/list"><i class="fas fa-angle-right mr-2"></i> Dashboards</a></li>
                        <li><a href="${pageContext.request.contextPath}/learning-path/list"><i class="fas fa-angle-right mr-2"></i> Learning Paths</a></li>
                        <li><a href="${pageContext.request.contextPath}/recommendation?userID=${sessionScope.userID}"><i class="fas fa-angle-right mr-2"></i> Recommendations</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4>Connect With Us</h4>
                    <p>Follow us on social media for updates and coding tips.</p>
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
                        <a href="#" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-discord"></i>
                        </a>
                    </div>
                </div>
            </div>
            <hr style="border-color: rgba(56, 189, 248, 0.2); margin: 2rem 0;">
            <p>&copy; 2025 PathCode Learning System. All rights reserved.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>