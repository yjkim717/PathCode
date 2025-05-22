<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Register - PathCode</title>
    <!-- Use local Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
            display: flex;
            align-items: center;
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
        
        /* Card Styling */
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            overflow: hidden;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
        }
        
        .card-header {
            background-color: rgba(15, 23, 42, 0.5);
            border-bottom: 1px solid var(--border-color);
            padding: 1.5rem;
            text-align: center;
        }
        
        .card-header h4 {
            color: var(--accent-blue);
            font-weight: 600;
            margin: 0;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        /* Form Styling */
        .form-group label {
            color: var(--text-secondary);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            background-color: rgba(15, 23, 42, 0.5);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            padding: 0.75rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            background-color: rgba(15, 23, 42, 0.7);
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 0.2rem rgba(56, 189, 248, 0.25);
            color: var(--text-primary);
        }
        
        .input-group-text {
            background-color: rgba(15, 23, 42, 0.5);
            border: 1px solid var(--border-color);
            border-right: none;
            color: var(--accent-blue);
        }
        
        /* Button Styling */
        .btn-primary {
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
            border: none;
            border-radius: 8px;
            padding: 0.75rem;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(56, 189, 248, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(56, 189, 248, 0.4);
        }
        
        /* Alert Styling */
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 1.5rem;
        }
        
        .alert-danger {
            background-color: rgba(220, 53, 69, 0.2);
            color: #ff6b6b;
            border-left: 4px solid #dc3545;
        }
        
        /* Password Strength Indicator */
        .password-strength {
            height: 4px;
            background: var(--bg-secondary);
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s ease, background-color 0.3s ease;
        }
        
        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: var(--text-secondary);
        }
        
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid var(--border-color);
        }
        
        .divider::before {
            margin-right: 1rem;
        }
        
        .divider::after {
            margin-left: 1rem;
        }
        
        /* Link Styling */
        a {
            color: var(--accent-blue);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        a:hover {
            color: var(--accent-purple);
            text-decoration: underline;
        }
        
        /* Animation */
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
    <div class="container animate-fade-in">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-user-plus"></i> Create an Account</h4>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle mr-2"></i> ${error}
                            </div>
                        <% } %>
                        
                        <form action="${pageContext.request.contextPath}/user/register" method="post" id="registerForm">
                            <div class="form-group mb-4">
                                <label for="username">Username</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="username" name="username" required 
                                           placeholder="Choose a username">
                                </div>
                            </div>
                            
                            <div class="form-group mb-4">
                                <label for="email">Email</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    </div>
                                    <input type="email" class="form-control" id="email" name="email" required 
                                           placeholder="Your email address">
                                </div>
                            </div>
                            
                            <div class="form-group mb-4">
                                <label for="password">Password</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input type="password" class="form-control" id="password" name="password" required 
                                           placeholder="Create a password">
                                </div>
                                <div class="password-strength mt-2">
                                    <div class="password-strength-bar" id="passwordStrength"></div>
                                </div>
                            </div>
                            
                            <div class="form-group mb-4">
                                <label for="confirmPassword">Confirm Password</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required 
                                           placeholder="Confirm your password">
                                </div>
                                <small id="passwordMatch" class="text-danger" style="display:none;">
                                    <i class="fas fa-exclamation-circle"></i> Passwords do not match
                                </small>
                            </div>
                            
                            <button type="submit" class="btn btn-primary btn-block btn-lg mb-4">
                                <i class="fas fa-user-plus mr-2"></i> Register
                            </button>
                            
                            <div class="divider">or</div>
                            
                            <div class="text-center">
                                <p class="mb-0">Already have an account? 
                                    <a href="${pageContext.request.contextPath}/user/login" class="font-weight-bold">Login here</a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Password strength indicator
            $('#password').on('input', function() {
                var password = $(this).val();
                var strength = 0;
                
                // Length check
                if (password.length > 7) strength += 1;
                // Contains numbers
                if (password.match(/\d/)) strength += 1;
                // Contains special chars
                if (password.match(/[^a-zA-Z0-9]/)) strength += 1;
                // Contains uppercase
                if (password.match(/[A-Z]/)) strength += 1;
                
                var width = (strength / 4) * 100;
                var color = '#dc3545'; // red
                
                if (strength >= 3) color = '#10B981'; // green
                else if (strength >= 2) color = '#F59E0B'; // amber
                
                $('#passwordStrength').css({
                    'width': width + '%',
                    'background-color': color
                });
            });
            
            // Password match validation
            $('#confirmPassword').on('input', function() {
                var password = $('#password').val();
                var confirmPassword = $(this).val();
                
                if (confirmPassword.length > 0 && password !== confirmPassword) {
                    $('#passwordMatch').show();
                } else {
                    $('#passwordMatch').hide();
                }
            });
            
            // Form submission validation
            $('#registerForm').on('submit', function(e) {
                var password = $('#password').val();
                var confirmPassword = $('#confirmPassword').val();
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    $('#passwordMatch').show();
                    $('#confirmPassword').focus();
                }
            });
        });
    </script>
</body>
</html>