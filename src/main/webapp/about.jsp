<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>About PathCode | PathCode Learning System</title>
    <!-- Use local Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Custom styles -->
    <style>
        /* Inherit all variables and base styles from index */
        :root {
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
        
        /* About page specific styles */
        .about-header {
            padding: 6rem 0 4rem;
            position: relative;
            overflow: hidden;
        }
        
        .about-header::before {
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
        
        .mission-card {
            border-left: 4px solid var(--accent-blue);
        }
        
        .team-member {
            transition: all 0.3s ease;
        }
        
        .team-member:hover {
            transform: translateY(-5px);
        }
        
        .team-member img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 3px solid var(--border-color);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .feature-icon-about {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            display: inline-block;
        }
        
        .feature-icon-about::after {
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
            .about-header {
                padding: 4rem 1rem;
            }
            
            .team-member img {
                width: 120px;
                height: 120px;
            }
        }
    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <!-- Particle Background -->
    <div id="particle-container"></div>
    
    <!-- Navigation -->
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
                        <div class="dropdown-menu dropdown-menu-right animate-fade-in" aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">
                                <i class="fas fa-sign-out-alt mr-2"></i> Logout
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- About Header -->
    <div class="about-header text-center">
        <div class="container position-relative animate-fade-in">
            <h1 class="display-4 mb-4" style="background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                About PathCode
            </h1>
            <p class="lead" style="color: var(--text-secondary); max-width: 800px; margin: 0 auto;">
                Revolutionizing the way developers learn and grow through personalized coding challenges and intelligent recommendations.
            </p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container my-5">
        <!-- Our Story Section -->
        <div class="row mb-5">
            <div class="col-lg-8 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <h2 class="mb-4" style="color: var(--accent-blue);">Our Story</h2>
                        <p style="color: var(--text-secondary); line-height: 1.8;">
                            PathCode was born out of our own frustrations as computer science students. We noticed that while 
                            there were plenty of coding practice platforms available, none offered truly personalized learning 
                            paths that adapted to individual skill levels and learning paces.
                        </p>
                        <p style="color: var(--text-secondary); line-height: 1.8;">
                            After graduating and entering the tech industry, we realized this problem extended far beyond 
                            academia. Many developers struggle to find appropriate challenges that help them grow without 
                            being overwhelming or too basic. That's when we decided to build PathCode - a platform that 
                            intelligently recommends coding problems based on your unique progress and skill set.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Mission Section -->
        <div class="row mb-5">
            <div class="col-md-6 mb-4">
                <div class="card h-100 mission-card">
                    <div class="card-body">
                        <h3 style="color: var(--accent-blue);">
                            <i class="fas fa-bullseye mr-2"></i>Our Mission
                        </h3>
                        <p style="color: var(--text-secondary);">
                            To create a learning platform that adapts to each developer's unique journey, providing 
                            the right challenges at the right time to maximize growth and minimize frustration.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card h-100 mission-card">
                    <div class="card-body">
                        <h3 style="color: var(--accent-blue);">
                            <i class="fas fa-eye mr-2"></i>Our Vision
                        </h3>
                        <p style="color: var(--text-secondary);">
                            A world where every developer, regardless of their background or experience level, 
                            has access to personalized learning resources that help them reach their full potential.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Key Features -->
        <div class="row mb-5">
            <div class="col-12 text-center mb-5">
                <h2 style="color: var(--accent-blue);">What Makes PathCode Special</h2>
                <p style="color: var(--text-secondary);">Everything you need to enhance your coding journey</p>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="feature-icon-about">
                            <i class="fas fa-brain"></i>
                        </div>
                        <h4 style="color: var(--accent-blue);">Intelligent Recommendations</h4>
                        <p style="color: var(--text-secondary);">
                            Our algorithm analyzes your progress to suggest problems that challenge you just enough to grow without being discouraging.
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="feature-icon-about">
                            <i class="fas fa-project-diagram"></i>
                        </div>
                        <h4 style="color: var(--accent-blue);">Skill-Based Learning Paths</h4>
                        <p style="color: var(--text-secondary);">
                            Structured paths that help you systematically build expertise in specific technologies or concepts.
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="feature-icon-about">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4 style="color: var(--accent-blue);">Progress Tracking</h4>
                        <p style="color: var(--text-secondary);">
                            Detailed analytics help you visualize your growth and identify areas for improvement.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body p-5 text-center">
                        <h3 style="color: var(--accent-blue);">Ready to start your coding journey?</h3>
                        <p class="lead" style="color: var(--text-secondary);">Join thousands of developers who have improved their skills with PathCode.</p>
                       
                        <a href="${pageContext.request.contextPath}/problem/list" class="btn btn-secondary btn-lg">
                            <i class="fas fa-project-diagram mr-2"></i> Browse Problems
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
                        <li><a href="${pageContext.request.contextPath}/about.jsp" class="text-white"><i class="fas fa-angle-right mr-2"></i> About</a></li>
                        <li><a href="${pageContext.request.contextPath}/problem/list" class="text-white"><i class="fas fa-angle-right mr-2"></i> Problems</a></li>
                        <li><a href="${pageContext.request.contextPath}/progress/user?userId=${sessionScope.userID}" class="text-white"><i class="fas fa-angle-right mr-2"></i> My Progress</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4>Connect With Us</h4>
                    <p style="color: var(--text-secondary);">Follow us on social media for updates and coding tips.</p>
                    <div class="mt-3" style="display: flex; justify-content: center; gap: 15px;">
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-github"></i>
                        </a>
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-linkedin"></i>
                        </a>
                    </div>
                </div>
            </div>
            <hr style="border-color: rgba(56, 189, 248, 0.2); margin: 2rem 0;">
            <p style="color: var(--text-secondary);">&copy; 2025 PathCode Learning System. All rights reserved.</p>
        </div>
    </footer>

    <!-- JavaScript includes -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    
    <!-- Particle Animation Script -->
    <script>
        // Create code particles
        const particleContainer = document.getElementById('particle-container');
        const codeSnippets = [
            'function getUser() { }', 
            'const data = await fetch(url);', 
            'if (x > 10) { return true; }',
            'class CodeParticle { }', 
            'import React from "react";', 
            'let array = [1, 2, 3];',
            'for (let i = 0; i < 10; i++) { }',
            'export default App;',
            '<div className="container">',
            'SELECT * FROM users;',
            'console.log("Hello");'
        ];
        
        function createParticle() {
            const particle = document.createElement('div');
            particle.classList.add('code-particle');
            
            // Random position
            const posX = Math.random() * window.innerWidth;
            const posY = Math.random() * window.innerHeight + window.innerHeight;
            
            // Random code snippet
            const snippet = codeSnippets[Math.floor(Math.random() * codeSnippets.length)];
            
            // Random size and duration
            const size = Math.random() * 0.3 + 0.7; // 0.7 to 1.0
            const duration = Math.random() * 10 + 15; // 15 to 25 seconds
            
            particle.style.left = `${posX}px`;
            particle.style.bottom = `${-50}px`; // Start below the screen
            particle.style.transform = `scale(${size})`;
            particle.style.animationDuration = `${duration}s`;
            particle.style.opacity = '0';
            particle.textContent = snippet;
            
            particleContainer.appendChild(particle);
            
            // Remove particle after animation completes
            setTimeout(() => {
                particle.remove();
            }, duration * 1000);
        }
        
        // Create particles at intervals
        setInterval(createParticle, 2000);
        
        // Create initial particles
        for (let i = 0; i < 10; i++) {
            setTimeout(createParticle, i * 300);
        }
        
        // Initialize dropdowns
        $(document).ready(function(){
            $('.dropdown-toggle').dropdown();
        });
    </script>
</body>
</html>