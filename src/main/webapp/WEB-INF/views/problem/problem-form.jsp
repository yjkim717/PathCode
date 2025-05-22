<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty problem ? 'Add New Problem' : 'Edit Problem'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fc;
        }
        .form-control:focus {
            border-color: #bac8f3;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        label {
            font-weight: 600;
            color: #5a5c69;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <i class="fas fa-code"></i> PathCode
        </a>
    </div>
</nav>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4><i class="fas fa-${empty problem ? 'plus' : 'edit'}"></i> ${empty problem ? 'Add New Problem' : 'Edit Problem'}</h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/problem/${empty problem ? 'insert' : 'update'}" method="post">
                <c:if test="${!empty problem}">
                    <input type="hidden" name="problemId" value="${problem.problemId}" />
                </c:if>

                <div class="form-group">
                    <label for="title"><i class="fas fa-heading"></i> Title</label>
                    <input type="text" class="form-control" name="title" id="title" value="${problem.title}" required />
                </div>

                <div class="form-group">
                    <label for="difficulty"><i class="fas fa-signal"></i> Difficulty</label>
                    <select class="form-control" name="difficulty" id="difficulty" required>
                        <option value="Easy" ${problem.difficulty == 'Easy' ? 'selected' : ''}>Easy</option>
                        <option value="Medium" ${problem.difficulty == 'Medium' ? 'selected' : ''}>Medium</option>
                        <option value="Hard" ${problem.difficulty == 'Hard' ? 'selected' : ''}>Hard</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="acceptance"><i class="fas fa-percentage"></i> Acceptance (%)</label>
                    <input type="number" step="0.01" class="form-control" name="acceptance" id="acceptance" value="${problem.acceptance}" required />
                </div>

                <div class="form-group form-check">
                    <input type="checkbox" class="form-check-input" name="isPremium" id="isPremium" ${problem.premium ? 'checked' : ''} />
                    <label class="form-check-label" for="isPremium"><i class="fas fa-star"></i> Premium Problem</label>
                </div>

                <div class="form-group">
                    <label for="questionLink"><i class="fas fa-link"></i> Question URL</label>
                    <input type="url" class="form-control" name="questionLink" id="questionLink" value="${problem.questionLink}" required />
                </div>

                <div class="form-group">
                    <label for="solutionLink"><i class="fas fa-lightbulb"></i> Solution URL</label>
                    <input type="url" class="form-control" name="solutionLink" id="solutionLink" value="${problem.solutionLink}" required />
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-${empty problem ? 'save' : 'sync'}"></i>
                        ${empty problem ? 'Add Problem' : 'Update Problem'}
                    </button>
                    <a href="${pageContext.request.contextPath}/problem/list" class="btn btn-secondary btn-lg ml-2">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<footer class="footer text-center mt-5">
    <div class="container">
        <hr>
        <p class="text-muted mb-0">© 2025 PathCode Learning System. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
