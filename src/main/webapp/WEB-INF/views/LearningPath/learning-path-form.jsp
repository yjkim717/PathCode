<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="${empty learningPath ? 'Create Learning Path' : 'Edit Learning Path'}" />
    <jsp:param name="activeMenu" value="learningPaths" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">${empty learningPath ? 'Create Learning Path' : 'Edit Learning Path'}</h1>
        <p class="text-secondary">${empty learningPath ? 'Create a new learning path' : 'Update existing learning path information'}</p>
    </div>
    <a href="${pageContext.request.contextPath}/learning-path/list" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to List
    </a>
</div>

<!-- Error Message Display (if any) -->
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger mb-4 animate-fade-in">
        <i class="fas fa-exclamation-circle mr-2"></i> ${errorMessage}
    </div>
</c:if>

<!-- Learning Path Form Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-project-diagram"></i> Learning Path Information
        </h6>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/learning-path/${empty learningPath ? 'insert' : 'update'}" method="post" class="user">
            <c:if test="${not empty learningPath}">
                <input type="hidden" name="id" value="${learningPath.id}" />
                <input type="hidden" name="assignedDate" value="${learningPath.assignedDate}" />
            </c:if>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="userId"><i class="fas fa-user"></i> User ID</label>
                        <input type="number" class="form-control" id="userId" name="userId" 
                               value="${not empty learningPath ? learningPath.userId : ''}" min="1" required>
                        <small class="form-text text-secondary">The ID of the user for this learning path</small>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="problemId"><i class="fas fa-code"></i> Problem ID</label>
                        <input type="number" class="form-control" id="problemId" name="problemId" 
                               value="${not empty learningPath ? learningPath.problemId : ''}" min="1" required>
                        <small class="form-text text-secondary">ID of the problem associated with this path</small>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="stage"><i class="fas fa-layer-group"></i> Stage</label>
                        <select class="form-control" id="stage" name="stage" required>
                            <c:forEach begin="1" end="10" var="i">
                                <option value="${i}" ${not empty learningPath && learningPath.stage == i ? 'selected' : ''}>${i}</option>
                            </c:forEach>
                        </select>
                        <small class="form-text text-secondary">The difficulty level or stage of this learning path</small>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="estimatedCompletionTime"><i class="fas fa-clock"></i> Est. Completion Time (hours)</label>
                        <input type="number" class="form-control" id="estimatedCompletionTime" 
                               name="estimatedCompletionTime" 
                               value="${not empty learningPath && not empty learningPath.estimatedCompletionTime ? learningPath.estimatedCompletionTime : '1'}" 
                               min="1">
                        <small class="form-text text-secondary">Estimated time to complete this learning path (in hours)</small>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="description"><i class="fas fa-info-circle"></i> Description</label>
                <textarea class="form-control" id="description" name="description" rows="3">${not empty learningPath ? learningPath.description : ''}</textarea>
                <small class="form-text text-secondary">Brief description of the learning path</small>
            </div>
            
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="isRequired" name="isRequired" 
                       ${not empty learningPath && learningPath.isRequired ? 'checked' : ''}>
                <label class="form-check-label" for="isRequired"><i class="fas fa-exclamation-circle"></i> Required Path</label>
                <small class="form-text text-secondary d-block">Mark if this is a required learning path</small>
            </div>
            
            <div class="mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> ${empty learningPath ? 'Create' : 'Update'} Learning Path
                </button>
                <c:if test="${not empty learningPath}">
                    <a href="${pageContext.request.contextPath}/learning-path/delete?id=${learningPath.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this learning path?')">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/learning-path/list" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/templates/footer.jsp" />

<!-- Form validation script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        
        form.addEventListener('submit', function(event) {
            // Basic validation
            const userId = document.getElementById('userId').value;
            const problemId = document.getElementById('problemId').value;
            const stage = document.getElementById('stage').value;
            
            let hasError = false;
            let errorMessage = '';
            
            if (!userId || userId < 1) {
                errorMessage += 'User ID must be a positive number. ';
                hasError = true;
            }
            
            if (!problemId || problemId < 1) {
                errorMessage += 'Problem ID must be a positive number. ';
                hasError = true;
            }
            
            if (!stage || stage < 1) {
                errorMessage += 'Stage must be selected. ';
                hasError = true;
            }
            
            if (hasError) {
                event.preventDefault();
                alert('Please fix the following errors: ' + errorMessage);
            }
        });
    });
</script>