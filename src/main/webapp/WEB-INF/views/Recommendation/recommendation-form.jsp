<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="${empty recommendation ? 'Add New Recommendation' : 'Edit Recommendation'}" />
    <jsp:param name="activeMenu" value="recommendations" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">${empty recommendation ? 'Add New Recommendation' : 'Edit Recommendation'}</h1>
        <p class="text-secondary">${empty recommendation ? 'Create a new problem recommendation' : 'Modify existing recommendation information'}</p>
    </div>
    <a href="${pageContext.request.contextPath}/recommendation/list" class="btn btn-light">
        <i class="fas fa-arrow-left"></i> Back to Recommendations
    </a>
</div>

<!-- Recommendation Form Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-lightbulb"></i> Recommendation Information
        </h6>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/recommendation/${empty recommendation ? 'insert' : 'update'}" method="post" class="needs-validation" novalidate>
            <c:if test="${not empty recommendation}">
                <input type="hidden" name="id" value="${recommendation.id}" />
                <input type="hidden" name="createdDate" value="${recommendation.createdDate}" />
            </c:if>
            
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="userId"><i class="fas fa-user"></i> User ID *</label>
                    <input type="number" class="form-control search-input" id="userId" name="userId" value="${recommendation.userId}" required>
                    <div class="invalid-feedback">
                        Please provide a user ID.
                    </div>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="problemId"><i class="fas fa-puzzle-piece"></i> Problem ID *</label>
                    <input type="number" class="form-control search-input" id="problemId" name="problemId" value="${recommendation.problemId}" required>
                    <div class="invalid-feedback">
                        Please provide a problem ID.
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="confidenceScore"><i class="fas fa-percentage"></i> Confidence Score (%)</label>
                    <input type="number" step="0.1" min="0" max="100" class="form-control search-input" id="confidenceScore" name="confidenceScore" value="${empty recommendation.confidenceScore ? 75.0 : recommendation.confidenceScore}">
                    <div class="form-text text-muted">
                        <small>Score from 0 to 100 indicating how confident the recommendation is.</small>
                    </div>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="recommendedDate"><i class="fas fa-calendar-alt"></i> Recommendation Date</label>
                    <input type="datetime-local" class="form-control search-input" id="recommendedDate" name="recommendedDate">
                    <div class="form-text text-muted">
                        <small>Leave blank to use current date/time.</small>
                    </div>
                </div>
            </div>
            
            <div class="form-group text-center mt-4">
                <button type="submit" class="btn btn-primary px-5 search-btn">
                    <i class="fas fa-save"></i> ${empty recommendation ? 'Create Recommendation' : 'Update Recommendation'}
                </button>
                <a href="${pageContext.request.contextPath}/recommendation/list" class="btn btn-light ml-2 search-btn">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<!-- JavaScript for form validation -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Form validation
        const form = document.querySelector('.needs-validation');
        
        form.addEventListener('submit', function(event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            form.classList.add('was-validated');
        }, false);
    });
</script>

<jsp:include page="/WEB-INF/templates/footer.jsp" />