<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="Dashboard Management" />
    <jsp:param name="activeMenu" value="dashboards" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">Dashboard Management</h1>
        <p class="text-secondary">View and manage all user dashboards in the system</p>
    </div>
    <a href="${pageContext.request.contextPath}/dashboard/new" class="btn btn-primary">
        <i class="fas fa-plus"></i> Add New Dashboard
    </a>
</div>

<!-- Dashboard List Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header py-3 d-flex justify-content-between align-items-center">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-tachometer-alt"></i> Dashboard List
        </h6>
        <div class="input-group search-box-container" style="width: 250px;">
            <input type="text" class="form-control search-input" placeholder="Search dashboards..." id="dashboardSearchInput">
            <div class="input-group-append">
                <button class="btn btn-primary search-btn" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="dashboardTable" width="100%" cellspacing="0">
                <thead class="thead-primary">
                    <tr>
                        <th><i class="fas fa-id-badge"></i> ID</th>
                        <th><i class="fas fa-user"></i> User ID</th>
                        <th><i class="fas fa-chart-bar"></i> Problems Solved</th>
                        <th><i class="fas fa-percentage"></i> Success Rate</th>
                        <th><i class="fas fa-clock"></i> Avg. Time</th>
                        <th><i class="fas fa-stream"></i> Stage</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dashboard" items="${dashboardList}">
                        <tr>
                            <td>${dashboard.id}</td>
                            <td>${dashboard.userId}</td>
                            <td>${dashboard.totalProblemsSolved} / ${dashboard.totalProblemsAttempted}</td>
                            <td>${dashboard.successRate}%</td>
                            <td>${dashboard.averageTimePerProblem} mins</td>
                            <td>
                                <span class="badge badge-${dashboard.currentStage <= 2 ? 'primary' : dashboard.currentStage <= 4 ? 'info' : dashboard.currentStage <= 6 ? 'success' : 'warning'}">
                                    Level ${dashboard.currentStage}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/dashboard/view?id=${dashboard.id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/dashboard/edit?id=${dashboard.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/dashboard/delete?id=${dashboard.id}" class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this dashboard?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Empty state for when there are no dashboards -->
        <c:if test="${empty dashboardList}">
            <div class="text-center py-5">
                <i class="fas fa-tachometer-alt fa-4x text-secondary mb-3"></i>
                <h5>No Dashboards Found</h5>
                <p class="text-secondary">There are no dashboards in the system yet.</p>
                <a href="${pageContext.request.contextPath}/dashboard/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add First Dashboard
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
                            Total Dashboards</div>
                        <div class="h5 mb-0 font-weight-bold">${dashboardList.size()}</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-tachometer-alt fa-2x text-secondary"></i>
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
                            Average Success Rate</div>
                        <div class="h5 mb-0 font-weight-bold">75%</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-percentage fa-2x text-secondary"></i>
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
                            Top Stage Achieved</div>
                        <div class="h5 mb-0 font-weight-bold">Level 8</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-trophy fa-2x text-secondary"></i>
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
                            Total Problems Solved</div>
                        <div class="h5 mb-0 font-weight-bold">486</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-check-circle fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Performance Insights Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-chart-line"></i> Performance Insights
        </h6>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-lg-6 mb-4">
                <h5 class="text-primary">Most Active Users</h5>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-primary">
                            <tr>
                                <th>User ID</th>
                                <th>Problems Solved</th>
                                <th>Success Rate</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>101</td>
                                <td>124</td>
                                <td>86%</td>
                            </tr>
                            <tr>
                                <td>105</td>
                                <td>98</td>
                                <td>92%</td>
                            </tr>
                            <tr>
                                <td>103</td>
                                <td>87</td>
                                <td>79%</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-lg-6">
                <h5 class="text-primary">Weekly Engagement Stats</h5>
                <div class="mb-3">
                    <p class="mb-1">Problems Solved This Week</p>
                    <div class="progress" style="height: 25px;">
                        <div class="progress-bar bg-info" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">75</div>
                    </div>
                </div>
                <div class="mb-3">
                    <p class="mb-1">Success Rate This Week</p>
                    <div class="progress" style="height: 25px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: 82%" aria-valuenow="82" aria-valuemin="0" aria-valuemax="100">82%</div>
                    </div>
                </div>
                <div class="mb-3">
                    <p class="mb-1">New Stage Achievements</p>
                    <div class="progress" style="height: 25px;">
                        <div class="progress-bar bg-warning" role="progressbar" style="width: 34%" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100">8 Users</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/templates/footer.jsp" />

<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Custom JavaScript -->
<script>
    $(document).ready(function() {
        // Dashboard search functionality
        $("#dashboardSearchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#dashboardTable tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
</rewritten_file>