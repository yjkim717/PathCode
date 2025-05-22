<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="View Recommendation" />
    <jsp:param name="activeMenu" value="recommendations" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">Recommendation Details</h1>
        <p class="text-secondary">Viewing detailed information for recommendation #${recommendation.id}</p>
    </div>
    <a href="${pageContext.request.contextPath}/recommendation/list" class="btn btn-light">
        <i class="fas fa-arrow-left"></i> Back to Recommendations
    </a>
</div>

<!-- Recommendation View Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-lightbulb"></i> Recommendation Information
        </h6>
    </div>
    <div class="card-body">
        <c:if test="${not empty recommendation}">
            <div class="row">
                <div class="col-lg-6">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Basic Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-hashtag mr-2"></i>Recommendation ID</span>
                                <h5>${recommendation.id}</h5>
                            </div>
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-user mr-2"></i>User ID</span>
                                <h5>${recommendation.userId}</h5>
                            </div>
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-puzzle-piece mr-2"></i>Problem ID</span>
                                <h5>${recommendation.problemId}</h5>
                            </div>
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-file-alt mr-2"></i>Problem Title</span>
                                <h5>${recommendation.problemTitle}</h5>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Recommendation Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-percentage mr-2"></i>Confidence Score</span>
                                <h5>
                                    <div class="progress" style="height: 25px;">
                                        <div class="progress-bar <c:choose>
                                                <c:when test="${recommendation.confidenceScore >= 80}">bg-success</c:when>
                                                <c:when test="${recommendation.confidenceScore >= 60}">bg-warning</c:when>
                                                <c:otherwise>bg-danger</c:otherwise>
                                             </c:choose>" 
                                             role="progressbar" 
                                             style="width: ${recommendation.confidenceScore}%;" 
                                             aria-valuenow="${recommendation.confidenceScore}" 
                                             aria-valuemin="0" 
                                             aria-valuemax="100">
                                            ${recommendation.confidenceScore}%
                                        </div>
                                    </div>
                                </h5>
                            </div>
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-calendar-check mr-2"></i>Recommended Date</span>
                                <h5><fmt:formatDate value="${recommendation.recommendedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></h5>
                            </div>
                            <div class="item-info mb-3">
                                <span class="text-secondary"><i class="fas fa-calendar-plus mr-2"></i>Created Date</span>
                                <h5><fmt:formatDate value="${recommendation.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Actions -->
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/recommendation/edit?id=${recommendation.id}" class="btn btn-warning">
                    <i class="fas fa-edit"></i> Edit Recommendation
                </a>
                <a href="${pageContext.request.contextPath}/recommendation/delete?id=${recommendation.id}" class="btn btn-danger ml-2" 
                   onclick="return confirm('Are you sure you want to delete this recommendation?')">
                    <i class="fas fa-trash-alt"></i> Delete Recommendation
                </a>
            </div>
        </c:if>
        
        <c:if test="${empty recommendation}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle mr-2"></i> Recommendation not found.
            </div>
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/recommendation/list" class="btn btn-primary">
                    <i class="fas fa-list"></i> View All Recommendations
                </a>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/templates/footer.jsp" />