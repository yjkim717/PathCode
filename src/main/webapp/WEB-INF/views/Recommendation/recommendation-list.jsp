<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="Recommendation Management" />
    <jsp:param name="activeMenu" value="recommendations" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">Recommendation Management</h1>
        <p class="text-secondary">View and manage all problem recommendations in the system</p>
    </div>
    <a href="${pageContext.request.contextPath}/recommendation/new" class="btn btn-primary">
        <i class="fas fa-plus"></i> Add New Recommendation
    </a>
</div>

<!-- Recommendation List Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header py-3 d-flex justify-content-between align-items-center">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-lightbulb"></i> Recommendation List
        </h6>
        <div class="input-group search-box-container" style="width: 250px;">
            <input type="text" class="form-control search-input" placeholder="Search recommendations..." id="searchInput">
            <div class="input-group-append">
                <button class="btn btn-primary search-btn" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="recommendationTable" width="100%" cellspacing="0">
                <thead class="thead-primary">
                    <tr>
                        <th><i class="fas fa-id-badge"></i> ID</th>
                        <th><i class="fas fa-user"></i> User</th>
                        <th><i class="fas fa-puzzle-piece"></i> Problem</th>
                        <th><i class="fas fa-percentage"></i> Confidence</th>
                        <th><i class="fas fa-calendar-alt"></i> Created Date</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="recommendation" items="${recommendationList}">
                        <tr>
                            <td>${recommendation.id}</td>
                            <td>${recommendation.userId}</td>
                            <td>
                                ${recommendation.problemId}
                                <c:if test="${not empty recommendation.problemTitle && recommendation.problemTitle != 'Unknown'}">
                                    - ${recommendation.problemTitle}
                                </c:if>
                            </td>
                            <td>
                                <span class="badge badge-${recommendation.confidenceScore >= 80 ? 'success' : recommendation.confidenceScore >= 60 ? 'warning' : 'danger'}">
                                    ${recommendation.confidenceScore}%
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty recommendation.createdDate}">
                                        ${recommendation.createdDate}
                                    </c:when>
                                    <c:otherwise>
                                        ${recommendation.recommendedDate}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/recommendation/view?id=${recommendation.id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/recommendation/edit?id=${recommendation.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/recommendation/delete?id=${recommendation.id}" class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this recommendation?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Empty state for when there are no recommendations -->
        <c:if test="${empty recommendationList}">
            <div class="text-center py-5">
                <i class="fas fa-lightbulb fa-4x text-secondary mb-3"></i>
                <h5>No Recommendations Found</h5>
                <p class="text-secondary">There are no recommendations in the system yet.</p>
                <a href="${pageContext.request.contextPath}/recommendation/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add First Recommendation
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
                            Total Recommendations</div>
                        <div class="h5 mb-0 font-weight-bold">${recommendationList.size()}</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-lightbulb fa-2x text-secondary"></i>
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
                            Average Confidence</div>
                        <div class="h5 mb-0 font-weight-bold">87%</div>
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
                            New This Month</div>
                        <div class="h5 mb-0 font-weight-bold">${recommendationList.size()}</div>
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
                            Users With Recommendations</div>
                        <div class="h5 mb-0 font-weight-bold">5</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-users fa-2x text-secondary"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/templates/footer.jsp" />