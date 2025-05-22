<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View User</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">PathCode</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/list">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/list">Dashboards</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-info text-white">
                <h4>User Details</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty user}">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>ID:</strong> ${user.id}</p>
                            <p><strong>Username:</strong> ${user.username}</p>
                            <p><strong>Email:</strong> ${user.email}</p>
                            <p><strong>Join Date:</strong> ${user.joinDate}</p>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/dashboard/user?userId=${user.id}" class="btn btn-primary mb-2">View Dashboard</a>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/user/edit?id=${user.id}" class="btn btn-warning mr-2">Edit</a>
                        <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">Back to List</a>
                    </div>
                </c:if>
                <c:if test="${empty user}">
                    <div class="alert alert-danger">User not found.</div>
                    <a href="${pageContext.request.contextPath}/user/list" class="btn btn-secondary">Back to List</a>
                </c:if>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white mt-5 p-4 text-center">
        <div class="container">
            <p>© 2024 PathCode Learning System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>