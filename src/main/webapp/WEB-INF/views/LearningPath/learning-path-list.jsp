<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="Learning Path Management" />
    <jsp:param name="activeMenu" value="learningPaths" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">Learning Path Management</h1>
        <p class="text-secondary">View and manage all learning paths in the system</p>
    </div>
    <a href="${pageContext.request.contextPath}/learning-path/new" class="btn btn-primary">
        <i class="fas fa-plus"></i> Add New Learning Path
    </a>
</div>

<!-- Error Message Display (if any) -->
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger mb-4 animate-fade-in">
        <i class="fas fa-exclamation-circle mr-2"></i> ${errorMessage}
    </div>
</c:if>

<!-- Success Message Display (if any) -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success mb-4 animate-fade-in">
        <i class="fas fa-check-circle mr-2"></i> ${successMessage}
    </div>
</c:if>

<!-- Session-based messages -->
<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger mb-4 animate-fade-in">
        <i class="fas fa-exclamation-circle mr-2"></i> ${sessionScope.errorMessage}
    </div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success mb-4 animate-fade-in">
        <i class="fas fa-check-circle mr-2"></i> ${sessionScope.successMessage}
    </div>
    <c:remove var="successMessage" scope="session" />
</c:if>

<!-- Learning Path List Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header py-3 d-flex justify-content-between align-items-center">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-project-diagram"></i> Learning Path List
        </h6>
        <div class="input-group" style="width: 250px;">
            <input type="text" class="form-control" placeholder="Search paths..." id="pathSearchInput">
            <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="learningPathTable" width="100%" cellspacing="0">
                <thead class="thead-primary">
                    <tr>
                        <th><i class="fas fa-id-badge"></i> ID</th>
                        <th><i class="fas fa-user"></i> User ID</th>
                        <th><i class="fas fa-code"></i> Problem ID</th>
                        <th><i class="fas fa-layer-group"></i> Stage</th>
                        <th><i class="fas fa-calendar-alt"></i> Assigned Date</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="learningPath" items="${learningPaths}">
                        <tr>
                            <td>${learningPath.id}</td>
                            <td>${learningPath.userId}</td>
                            <td>${learningPath.problemId}</td>
                            <td>
                                <span class="badge badge-${learningPath.stage <= 2 ? 'primary' : learningPath.stage <= 4 ? 'info' : learningPath.stage <= 6 ? 'success' : 'warning'}">
                                    Level ${learningPath.stage}
                                </span>
                            </td>
                            <td>${learningPath.assignedDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/learning-path/view?id=${learningPath.id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/learning-path/edit?id=${learningPath.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/learning-path/delete?id=${learningPath.id}" class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this learning path?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Empty state for when there are no learning paths -->
        <c:if test="${empty learningPaths}">
            <div class="text-center py-5">
                <i class="fas fa-project-diagram fa-4x text-secondary mb-3"></i>
                <h5>No Learning Paths Found</h5>
                <p class="text-secondary">There are no learning paths in the system yet.</p>
                <a href="${pageContext.request.contextPath}/learning-path/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add First Learning Path
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
                            Total Paths</div>
                        <div class="h5 mb-0 font-weight-bold">
                            <c:choose>
                                <c:when test="${not empty learningPaths}">${learningPaths.size()}</c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-project-diagram fa-2x text-secondary"></i>
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
                        <div class="h5 mb-0 font-weight-bold">${activeUsersCount}</div>
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
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                            Completion Rate</div>
                        <div class="h5 mb-0 font-weight-bold">${completionRate}%</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-graduation-cap fa-2x text-secondary"></i>
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
                            Avg. Completion Time</div>
                        <div class="h5 mb-0 font-weight-bold">${avgCompletionTime} days</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clock fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Learning Path Analytics Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-chart-bar"></i> Learning Path Analytics
        </h6>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-lg-6 mb-4">
                <h5 class="text-primary">Most Popular Learning Paths</h5>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-primary">
                            <tr>
                                <th>Path ID</th>
                                <th>Users Enrolled</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="path" items="${popularPaths}">
                                <tr>
                                    <td>${path.key}</td>
                                    <td>${path.value}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty popularPaths}">
                                <tr>
                                    <td colspan="2" class="text-center">No data available</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-lg-6">
                <h5 class="text-primary">Path Difficulty Distribution</h5>
                <div class="mb-3">
                    <p class="mb-1">Beginner Paths (Stages 1-3)</p>
                    <div class="progress" style="height: 25px;">
                        <div class="progress-bar bg-primary" role="progressbar" style="width: ${difficultyDistribution.beginner}%">${difficultyDistribution.beginner}%</div>
                    </div>
                </div>
                <div class="mb-3">
                    <p class="mb-1">Intermediate Paths (Stages 4-6)</p>
                    <div class="progress" style="height: 25px;">
                        <div class="progress-bar bg-info" role="progressbar" style="width: ${difficultyDistribution.intermediate}%">${difficultyDistribution.intermediate}%</div>
                    </div>
                </div>
                <div class="mb-3">
                    <p class="mb-1">Advanced Paths (Stages 7+)</p>
                    <div class="progress" style="height: 25px;">
                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${difficultyDistribution.advanced}%">${difficultyDistribution.advanced}%</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/templates/footer.jsp" />

<!-- JavaScript -->
<script>
    $(document).ready(function() {
        // Learning path search functionality
        $("#pathSearchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#learningPathTable tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>