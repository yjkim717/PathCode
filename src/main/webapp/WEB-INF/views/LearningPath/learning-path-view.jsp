<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="Learning Path Details" />
    <jsp:param name="activeMenu" value="learningPaths" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">Learning Path Details</h1>
        <c:if test="${not empty learningPath}">
            <p class="text-secondary">Viewing details for learning path ID: ${learningPath.id}</p>
        </c:if>
    </div>
    <div>
        <c:if test="${not empty learningPath}">
            <a href="${pageContext.request.contextPath}/learning-path/edit?id=${learningPath.id}" class="btn btn-warning mr-2">
                <i class="fas fa-edit"></i> Edit
            </a>
        </c:if>
        <a href="${pageContext.request.contextPath}/learning-path/list" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to List
        </a>
    </div>
</div>

<!-- Error Message Display (if any) -->
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger mb-4 animate-fade-in">
        <i class="fas fa-exclamation-circle mr-2"></i> ${errorMessage}
    </div>
</c:if>

<c:if test="${not empty learningPath}">
    <!-- Learning Path Overview Card -->
    <div class="card mb-4 animate-fade-in">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
                <i class="fas fa-project-diagram"></i> Learning Path Overview
            </h6>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h5 class="border-bottom pb-2 mb-3">Path Information</h5>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-id-badge"></i> Path ID:</div>
                        <div class="col-7 font-weight-bold">${learningPath.id}</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-user"></i> User ID:</div>
                        <div class="col-7 font-weight-bold">${learningPath.userId}</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-code"></i> Problem ID:</div>
                        <div class="col-7 font-weight-bold">${learningPath.problemId}</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-layer-group"></i> Stage:</div>
                        <div class="col-7 font-weight-bold">
                            <span class="badge badge-${learningPath.stage <= 2 ? 'primary' : learningPath.stage <= 4 ? 'info' : learningPath.stage <= 6 ? 'success' : 'warning'}">
                                Level ${learningPath.stage}
                            </span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-calendar-alt"></i> Assigned Date:</div>
                        <div class="col-7 font-weight-bold">${learningPath.assignedDate}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h5 class="border-bottom pb-2 mb-3">Additional Details</h5>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-clock"></i> Est. Completion Time:</div>
                        <div class="col-7 font-weight-bold">
                            <c:choose>
                                <c:when test="${not empty learningPath.estimatedCompletionTime}">${learningPath.estimatedCompletionTime} hours</c:when>
                                <c:otherwise>Not specified</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-exclamation-circle"></i> Required Path:</div>
                        <div class="col-7 font-weight-bold">
                            <c:choose>
                                <c:when test="${learningPath.isRequired == true}">
                                    <span class="badge badge-danger">Required</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-secondary">Optional</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-5 text-secondary"><i class="fas fa-tasks"></i> Progress:</div>
                        <div class="col-7">
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100">65%</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="mt-4">
                <h5 class="border-bottom pb-2 mb-3">Description</h5>
                <p>
                    <c:choose>
                        <c:when test="${not empty learningPath.description}">${learningPath.description}</c:when>
                        <c:otherwise>No description available for this learning path.</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>
    
    <!-- Associated Problems Card -->
    <div class="card mb-4 animate-fade-in">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
                <i class="fas fa-code"></i> Associated Problem
            </h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-primary">
                        <tr>
                            <th>Problem ID</th>
                            <th>Title</th>
                            <th>Difficulty</th>
                            <th>Category</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${learningPath.problemId}</td>
                            <td>Binary Search Implementation</td>
                            <td><span class="badge badge-info">Medium</span></td>
                            <td>Algorithms</td>
                            <td>
                                <a href="#" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i> View Problem
                                </a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Progress Tracking Card -->
    <div class="card mb-4 animate-fade-in">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
                <i class="fas fa-chart-line"></i> Progress Tracking
            </h6>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <canvas id="progressChart" height="250"></canvas>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${empty learningPath}">
    <div class="alert alert-danger animate-fade-in">
        <i class="fas fa-exclamation-circle mr-2"></i> Learning Path not found.
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/learning-path/list" class="btn btn-primary">
            <i class="fas fa-arrow-left"></i> Back to Learning Path List
        </a>
    </div>
</c:if>

<jsp:include page="/WEB-INF/templates/footer.jsp" />

<!-- Chart.js for the progress chart -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Only initialize if the element exists
        if (document.getElementById('progressChart')) {
            try {
                // Sample data for the chart
                const progressData = {
                    labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                    datasets: [
                        {
                            label: 'Progress (%)',
                            data: [15, 35, 50, 65],
                            borderColor: '#4e73df',
                            backgroundColor: 'rgba(78, 115, 223, 0.1)',
                            tension: 0.3,
                            fill: true
                        }
                    ]
                };

                // Create the chart
                const ctx = document.getElementById('progressChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: progressData,
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                                labels: {
                                    color: '#f8f9fc'
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false
                            }
                        },
                        scales: {
                            y: {
                                ticks: {
                                    color: '#f8f9fc'
                                },
                                grid: {
                                    color: 'rgba(255, 255, 255, 0.1)'
                                }
                            },
                            x: {
                                ticks: {
                                    color: '#f8f9fc'
                                },
                                grid: {
                                    color: 'rgba(255, 255, 255, 0.1)'
                                }
                            }
                        }
                    }
                });
            } catch (err) {
                console.error("Error initializing chart:", err);
                document.getElementById('progressChart').innerHTML = '<div class="alert alert-warning">Error loading chart</div>';
            }
        }
    });
</script>