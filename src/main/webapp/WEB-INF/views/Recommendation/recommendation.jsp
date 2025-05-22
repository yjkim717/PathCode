<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pathcode.model.Recommendation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Recommendations | PathCode</title>
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
            transform: translateY(-10px);
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
            left: 50%;
            bottom: -10px;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
        }
        
        .lead {
            color: var(--text-secondary);
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
        
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .card-body {
                padding: 1.2rem;
            }
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
                    <li class="nav-item">

                        <a class="nav-link" href="${pageContext.request.contextPath}/progress/user?userId=${sessionScope.userID}">
                            <i class="fas fa-tachometer-alt"></i> My Progress
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
        <div class="text-center mb-5">
            <h2><i class="fas fa-lightbulb mr-2"></i>Recommendations</h2>
            <p class="lead">Here are some tailored problem recommendations based on your learning progress.</p>
        </div>

        <div class="card shadow">
            <div class="card-header">
                <i class="fas fa-table mr-2"></i>Recommended Problems
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Problem ID</th>
                                <th>Problem Name</th>
                                <th>Difficulty</th>
                                <th>Tag</th>
                                <th>View</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations");
                                if (recommendations != null && !recommendations.isEmpty()) {
                                    for (Recommendation recommendation : recommendations) {
                            %>
                                    <tr>
                                        <td><%= recommendation.getProblemId() %></td>
                                        <td><%= recommendation.getProblemName() %></td>
                                        <td>
                                            <span class="badge <%= recommendation.getDifficulty().equalsIgnoreCase("easy") ? "badge-easy" : 
                                                           recommendation.getDifficulty().equalsIgnoreCase("medium") ? "badge-medium" : "badge-hard" %>">
                                                <%= recommendation.getDifficulty() %>
                                            </span>
                                        </td>
                                        <td><%= recommendation.getTag() %></td>
                                        <td>
                                        <a href="<%= recommendation.getQuestionLink() %>" target="_blank" class="btn btn-info btn-sm mr-2">
                                            <i class="fas fa-external-link-alt mr-1"></i> Solve
                                           </a>
                                        </td>
                                        
                                    </tr>
                            <%
                                    }
                                } else {
                            %>
                                    <tr>
                                        <td colspan="4" class="text-center">
                                            <div class="empty-state">
                                                <i class="fas fa-lightbulb fa-3x"></i>
                                                <h5 class="mt-3">No recommendations available</h5>
                                                <p>Complete more problems to get personalized recommendations.</p>
                                            </div>
                                        </td>
                                    </tr>
                            <%
                                }
                            %>
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
                    <p>Helping developers master programming one step at a time.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4>Quick Links</h4>
                    <ul class="list-unstyled">

                        <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-angle-right mr-2"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/dashboard/view?userID=${sessionScope.userID}"><i class="fas fa-angle-right mr-2"></i> Dashboards</a></li>
                        <li><a href="${pageContext.request.contextPath}/learning-path/list"><i class="fas fa-angle-right mr-2"></i> Learning Paths</a></li>
                        <li><a href="${pageContext.request.contextPath}/recommendation?userID=${sessionScope.userID}"><i class="fas fa-angle-right mr-2"></i> Recommendations</a></li>                    </ul>
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

    <!-- Use local Bootstrap JS files -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>