<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
	<jsp:param name="pageTitle" value="Dashboard Details" />
	<jsp:param name="activeMenu" value="dashboards" />
</jsp:include>

<!-- Page Header -->
<div
	class="page-header d-flex justify-content-between align-items-center">
	<div>
		<h1 class="page-title">My Dashboard</h1>
		<%-- <p class="text-secondary">Viewing dashboard data for User ID:
			${dashboard.userId}</p> --%>
	</div>
</div>

<!-- Dashboard Overview Card -->
<div class="card mb-4 animate-fade-in">

	<div class="card-header">
		<h6 class="m-0 font-weight-bold text-primary">
			<i class="fas fa-tachometer-alt"></i> Dashboard Overview
		</h6>
	</div>
	<div class="card-body">
		<div class="row">
			<div class="col-md-6">
				<h5 class="border-bottom pb-2 mb-3">User Information</h5>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-id-badge"></i> Dashboard ID:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.id}</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-user"></i> User ID:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.userId}</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-level-up-alt"></i> User Name:
					</div>
					<div class="col-7 font-weight-bold">${sessionScope.username}</div>

				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-code"></i> Preferred Language:
					</div>
					<div class="col-7 font-weight-bold">Python</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-calendar-alt"></i> Last Active:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.lastActiveDate}</div>
				</div>
			</div>

			<div class="col-md-6">
				<h5 class="border-bottom pb-2 mb-3">Performance Stats</h5>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-question-circle"></i> Problems Attempted:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.totalProblemsAttempted}</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-check-circle"></i> Problems Solved:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.totalProblemsSolved}</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-percentage"></i> Success Rate:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.successRate}%</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-clock"></i> Avg. Time:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.averageTimePerProblem}
						mins/problem</div>
				</div>
				<div class="row mb-2">
					<div class="col-5 text-secondary">
						<i class="fas fa-fire"></i> Current Streak:
					</div>
					<div class="col-7 font-weight-bold">${dashboard.currentStreak}
						days</div>
				</div>
			</div>
		</div>

		<%-- 
        <div class="mt-4">
            <h5 class="border-bottom pb-2 mb-3">Learning Focus Areas</h5>
            <p>No focus areas specified yet. Focus areas will be determined based on your problem-solving history.</p>
        </div>
--%>

	</div>
</div>

<!-- Progress Chart Card -->
<div class="card mb-4 animate-fade-in">
	<div class="card-header">
		<h6 class="m-0 font-weight-bold text-primary">
			<i class="fas fa-chart-line"></i> Progress Over Time
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

<!-- Recent Activities Card -->
<div class="card mb-4 animate-fade-in">
	<div
		class="card-header d-flex justify-content-between align-items-center">
		<h6 class="m-0 font-weight-bold text-primary">
			<i class="fas fa-history"></i> Recent Activities
		</h6>
		<button class="btn btn-sm btn-primary">
			<i class="fas fa-sync"></i> Refresh
		</button>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered table-hover">
				<thead class="thead-primary">
					<tr>
						<th>Last Attempt Date</th>
						<th>Attempts</th>
						<th>Problem Name</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<!-- Limit the loop to 3 entries -->
					<c:forEach var="progress" items="${listUserProgress}"
						varStatus="status">
						<c:if test="${status.index < 3}">
							<tr>
								<td>${progress.lastAttemptDate}</td>
								<td>${progress.attempts}</td>
								<td>
									Problem ${progress.difficulty} <!-- Placeholder for actual problem name -->
								</td>
								<td><c:choose>
										<c:when test="${progress.solved}">
											<span class="badge badge-success">Completed</span>
										</c:when>
										<c:when test="${progress.attempts < 3}">
											<span class="badge badge-info">In Progress</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-danger">Stuck</span>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Recommendations Card -->
<div class="card mb-4 animate-fade-in">
	<div class="card-header">
		<h6 class="m-0 font-weight-bold text-primary">
			<i class="fas fa-lightbulb"></i> Personalized Recommendations
		</h6>
	</div>
	<div class="card-body">
		<div class="row">
			<div class="col-lg-4 mb-4">
				<div class="card h-100">
					<div class="card-body">
						<h5 class="card-title">
							<i class="fas fa-puzzle-piece"></i> Next Problem
						</h5>
						<p class="card-text">Binary Search Tree Implementation</p>
						<span class="badge badge-primary">Data Structures</span> <span
							class="badge badge-success">Medium</span>
					</div>
					<div class="card-footer">
						<a href="#" class="btn btn-primary btn-sm">Start Now</a>
					</div>
				</div>
			</div>
			<div class="col-lg-4 mb-4">
				<div class="card h-100">
					<div class="card-body">
						<h5 class="card-title">
							<i class="fas fa-book"></i> Recommended Reading
						</h5>
						<p class="card-text">Advanced Dynamic Programming Techniques</p>
						<span class="badge badge-info">Tutorial</span> <span
							class="badge badge-warning">Advanced</span>
					</div>
					<div class="card-footer">
						<a href="#" class="btn btn-primary btn-sm">Read Now</a>
					</div>
				</div>

			</div>
			<div class="col-lg-4 mb-4">
				<div class="card h-100">
					<div class="card-body">
						<h5 class="card-title">
							<i class="fas fa-project-diagram"></i> Learning Path
						</h5>
						<p class="card-text">Complete Backend Development Track</p>
						<span class="badge badge-secondary">17 Modules</span> <span
							class="badge badge-danger">32% Complete</span>
					</div>
					<div class="card-footer">
						<a href="#" class="btn btn-primary btn-sm">Continue</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/templates/footer.jsp" />

<!-- Chart.js for the progress chart -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Get the problems solved and success rate lists passed from the backend
        const problemsSolvedData = ${problemsSolvedList};  // List of problems solved
        const successRateData = ${successRateList};        // List of success rate percentages

        // Week labels (assuming you want to show the last 6 weeks, you can adjust the labels accordingly)
        const weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6'];

        // Create the chart data object
        const progressData = {
            labels: weeks,
            datasets: [
                {
                    label: 'Problems Solved',
                    data: problemsSolvedData,
                    borderColor: '#4e73df',
                    backgroundColor: 'rgba(78, 115, 223, 0.1)',
                    tension: 0.3,
                    fill: true
                },
                {
                    label: 'Success Rate (%)',
                    data: successRateData,
                    borderColor: '#1cc88a',
                    backgroundColor: 'rgba(28, 200, 138, 0.1)',
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
    });
</script>
