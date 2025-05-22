<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="${dashboard.id != null ? 'Edit Dashboard' : 'Create Dashboard'}" />
    <jsp:param name="activeMenu" value="dashboards" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">${dashboard.id != null ? 'Edit Dashboard' : 'Create Dashboard'}</h1>
        <p class="text-secondary">${dashboard.id != null ? 'Update the dashboard information' : 'Create a new user dashboard'}</p>
    </div>
    <a href="${pageContext.request.contextPath}/dashboard/list" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to List
    </a>
</div>

<!-- Dashboard Form Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-tachometer-alt"></i> Dashboard Information
        </h6>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/dashboard/${dashboard.id != null ? 'update' : 'create'}" method="post" class="user">
            <c:if test="${dashboard.id != null}">
                <input type="hidden" name="id" value="${dashboard.id}" />
            </c:if>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="userId"><i class="fas fa-user"></i> User ID</label>
                        <input type="number" class="form-control" id="userId" name="userId" value="${dashboard.userId}" required ${dashboard.id != null ? 'readonly' : ''}>
                        <small class="form-text text-secondary">The ID of the user for this dashboard</small>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user-tag"></i> Username</label>
                        <input type="text" class="form-control" id="username" name="username" value="${dashboard.username}" readonly>
                        <small class="form-text text-secondary">Username is for reference only</small>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="totalProblemsAttempted"><i class="fas fa-question-circle"></i> Total Problems Attempted</label>
                        <input type="number" class="form-control" id="totalProblemsAttempted" name="totalProblemsAttempted" value="${dashboard.totalProblemsAttempted}" required min="0">
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="totalProblemsSolved"><i class="fas fa-check-circle"></i> Total Problems Solved</label>
                        <input type="number" class="form-control" id="totalProblemsSolved" name="totalProblemsSolved" value="${dashboard.totalProblemsSolved}" required min="0">
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="successRate"><i class="fas fa-percentage"></i> Success Rate (%)</label>
                        <input type="number" class="form-control" id="successRate" name="successRate" value="${dashboard.successRate}" required min="0" max="100" step="0.1">
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="currentStage"><i class="fas fa-level-up-alt"></i> Current Stage</label>
                        <select class="form-control" id="currentStage" name="currentStage" required>
                            <c:forEach begin="1" end="10" var="i">
                                <option value="${i}" ${dashboard.currentStage == i ? 'selected' : ''}>${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="averageTimePerProblem"><i class="fas fa-clock"></i> Average Time Per Problem (min)</label>
                        <input type="number" class="form-control" id="averageTimePerProblem" name="averageTimePerProblem" value="${dashboard.averageTimePerProblem}" required min="0" step="0.1">
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="preferredProgrammingLanguage"><i class="fas fa-code"></i> Preferred Programming Language</label>
                        <select class="form-control" id="preferredProgrammingLanguage" name="preferredProgrammingLanguage" required>
                            <option value="Java" ${dashboard.preferredProgrammingLanguage == 'Java' ? 'selected' : ''}>Java</option>
                            <option value="Python" ${dashboard.preferredProgrammingLanguage == 'Python' ? 'selected' : ''}>Python</option>
                            <option value="JavaScript" ${dashboard.preferredProgrammingLanguage == 'JavaScript' ? 'selected' : ''}>JavaScript</option>
                            <option value="C++" ${dashboard.preferredProgrammingLanguage == 'C++' ? 'selected' : ''}>C++</option>
                            <option value="C#" ${dashboard.preferredProgrammingLanguage == 'C#' ? 'selected' : ''}>C#</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="learningFocus"><i class="fas fa-bullseye"></i> Learning Focus Areas</label>
                <textarea class="form-control" id="learningFocus" name="learningFocus" rows="3">${dashboard.learningFocus}</textarea>
                <small class="form-text text-secondary">Comma-separated list of focus areas (e.g. Algorithms, Data Structures, Web Development)</small>
            </div>
            
            <hr>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="active" name="active" ${dashboard.active ? 'checked' : ''}>
                        <label class="form-check-label" for="active"><i class="fas fa-toggle-on"></i> Active Status</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="recommendationsEnabled" name="recommendationsEnabled" ${dashboard.recommendationsEnabled ? 'checked' : ''}>
                        <label class="form-check-label" for="recommendationsEnabled"><i class="fas fa-lightbulb"></i> Enable Recommendations</label>
                    </div>
                </div>
            </div>
            
            <div class="mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> ${dashboard.id != null ? 'Update' : 'Create'} Dashboard
                </button>
                <c:if test="${dashboard.id != null}">
                    <a href="${pageContext.request.contextPath}/dashboard/delete?id=${dashboard.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this dashboard?')">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/dashboard/list" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<c:if test="${dashboard.id != null}">
    <!-- Recent Activities Card -->
    <div class="card mb-4 animate-fade-in">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
                <i class="fas fa-history"></i> Recent Activities
            </h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-primary">
                        <tr>
                            <th>Date</th>
                            <th>Activity</th>
                            <th>Problem</th>
                            <th>Result</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample data - in a real app this would be populated from a database -->
                        <tr>
                            <td>2023-04-05 14:30</td>
                            <td>Solved Problem</td>
                            <td>Binary Tree Traversal</td>
                            <td><span class="badge badge-success">Correct</span></td>
                        </tr>
                        <tr>
                            <td>2023-04-04 10:15</td>
                            <td>Attempted Problem</td>
                            <td>Dynamic Programming Challenge</td>
                            <td><span class="badge badge-danger">Incorrect</span></td>
                        </tr>
                        <tr>
                            <td>2023-04-03 16:45</td>
                            <td>Completed Tutorial</td>
                            <td>Introduction to Graphs</td>
                            <td><span class="badge badge-info">Completed</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="/WEB-INF/templates/footer.jsp" />