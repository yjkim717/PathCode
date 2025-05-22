<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="User Management" />
    <jsp:param name="activeMenu" value="users" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">User Management</h1>
        <p class="text-secondary">View and manage all users in the system</p>
    </div>
    <a href="${pageContext.request.contextPath}/user/new" class="btn btn-primary">
        <i class="fas fa-user-plus"></i> Add New User
    </a>
</div>

<!-- User List Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header py-3 d-flex justify-content-between align-items-center">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-users"></i> User List
        </h6>
        <div class="input-group search-box-container" style="width: 250px;">
            <input type="text" class="form-control search-input" placeholder="Search users..." id="userSearchInput">
            <div class="input-group-append">
                <button class="btn btn-primary search-btn" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="userTable" width="100%" cellspacing="0">
                <thead class="thead-primary">
                    <tr>
                        <th><i class="fas fa-id-badge"></i> ID</th>
                        <th><i class="fas fa-user"></i> Username</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-calendar-alt"></i> Join Date</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.joinDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/user/view?id=${user.id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/user/edit?id=${user.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/user/delete?id=${user.id}" class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this user?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Empty state for when there are no users -->
        <c:if test="${empty userList}">
            <div class="text-center py-5">
                <i class="fas fa-users fa-4x text-secondary mb-3"></i>
                <h5>No Users Found</h5>
                <p class="text-secondary">There are no users in the system yet.</p>
                <a href="${pageContext.request.contextPath}/user/new" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Add First User
                </a>
            </div>
        </c:if>
    </div>
</div>

<!-- Quick Stats Cards -->
<div class="row">
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card h-100">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            Total Users</div>
                        <div class="h5 mb-0 font-weight-bold">${userList.size()}</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-users fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card h-100">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                            Active Users</div>
                        <div class="h5 mb-0 font-weight-bold">${userList.size()}</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-user-check fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card h-100">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                            New This Month</div>
                        <div class="h5 mb-0 font-weight-bold">0</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card h-100">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                            Average Activity</div>
                        <div class="h5 mb-0 font-weight-bold">0 hrs</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clock fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/templates/footer.jsp" />