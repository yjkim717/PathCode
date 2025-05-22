<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/templates/header.jsp">
    <jsp:param name="pageTitle" value="${empty user.id ? 'Add New User' : 'Edit User'}" />
    <jsp:param name="activeMenu" value="users" />
</jsp:include>

<!-- Page Header -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <h1 class="page-title">${empty user.id ? 'Add New User' : 'Edit User'}</h1>
        <p class="text-secondary">${empty user.id ? 'Create a new user in the system' : 'Modify existing user information'}</p>
    </div>
    <a href="${pageContext.request.contextPath}/user/list" class="btn btn-light">
        <i class="fas fa-arrow-left"></i> Back to Users
    </a>
</div>

<!-- User Form Card -->
<div class="card mb-4 animate-fade-in">
    <div class="card-header">
        <h6 class="m-0 font-weight-bold text-primary">
            <i class="fas fa-user-edit"></i> User Information
        </h6>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/user/${empty user.id ? 'insert' : 'update'}" method="post" class="needs-validation" novalidate>
            <c:if test="${not empty user.id}">
                <input type="hidden" name="id" value="${user.id}" />
            </c:if>
            
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="username"><i class="fas fa-user"></i> Username *</label>
                    <input type="text" class="form-control search-input" id="username" name="username" value="${user.username}" required>
                    <div class="invalid-feedback">
                        Please provide a username.
                    </div>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email *</label>
                    <input type="email" class="form-control search-input" id="email" name="email" value="${user.email}" required>
                    <div class="invalid-feedback">
                        Please provide a valid email.
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password ${empty user.id ? '*' : '(leave blank to keep current)'}</label>
                    <input type="password" class="form-control search-input" id="password" name="password" ${empty user.id ? 'required' : ''}>
                    <div class="invalid-feedback">
                        Please provide a password.
                    </div>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password ${empty user.id ? '*' : ''}</label>
                    <input type="password" class="form-control search-input" id="confirmPassword" name="confirmPassword" ${empty user.id ? 'required' : ''}>
                    <div class="invalid-feedback">
                        Passwords do not match.
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="firstName"><i class="fas fa-user-tag"></i> First Name</label>
                    <input type="text" class="form-control search-input" id="firstName" name="firstName" value="${user.firstName}">
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="lastName"><i class="fas fa-user-tag"></i> Last Name</label>
                    <input type="text" class="form-control search-input" id="lastName" name="lastName" value="${user.lastName}">
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="role"><i class="fas fa-user-shield"></i> Role *</label>
                    <select class="form-control search-input" id="role" name="role" required>
                        <option value="" disabled ${empty user.role ? 'selected' : ''}>-- Select Role --</option>
                        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Administrator</option>
                        <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Regular User</option>
                        <option value="INSTRUCTOR" ${user.role == 'INSTRUCTOR' ? 'selected' : ''}>Instructor</option>
                    </select>
                    <div class="invalid-feedback">
                        Please select a role.
                    </div>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="status"><i class="fas fa-toggle-on"></i> Status *</label>
                    <select class="form-control search-input" id="status" name="status" required>
                        <option value="" disabled ${empty user.status ? 'selected' : ''}>-- Select Status --</option>
                        <option value="ACTIVE" ${user.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                        <option value="INACTIVE" ${user.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                        <option value="PENDING" ${user.status == 'PENDING' ? 'selected' : ''}>Pending Activation</option>
                    </select>
                    <div class="invalid-feedback">
                        Please select a status.
                    </div>
                </div>
            </div>
            
            <hr>
            
            <div class="row">
                <div class="col-md-12">
                    <h5 class="text-primary"><i class="fas fa-info-circle"></i> Additional Information</h5>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="bio"><i class="fas fa-comment-alt"></i> Bio</label>
                    <textarea class="form-control search-input" id="bio" name="bio" rows="3">${user.bio}</textarea>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="preferences"><i class="fas fa-sliders-h"></i> Preferences</label>
                    <textarea class="form-control search-input" id="preferences" name="preferences" rows="3">${user.preferences}</textarea>
                </div>
            </div>
            
            <div class="form-group text-center mt-4">
                <button type="submit" class="btn btn-primary px-5 search-btn">
                    <i class="fas fa-save"></i> ${empty user.id ? 'Create User' : 'Update User'}
                </button>
                <a href="${pageContext.request.contextPath}/user/list" class="btn btn-light ml-2 search-btn">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<!-- JavaScript for form validation -->
<script>
    // Add this after our page is loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Form validation
        const form = document.querySelector('.needs-validation');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        
        form.addEventListener('submit', function(event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            // Check if passwords match
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match.');
                event.preventDefault();
                event.stopPropagation();
            } else {
                confirmPassword.setCustomValidity('');
            }
            
            form.classList.add('was-validated');
        }, false);
        
        // Clear custom validity when typing in password fields
        password.addEventListener('input', function() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match.');
            } else {
                confirmPassword.setCustomValidity('');
            }
        });
        
        confirmPassword.addEventListener('input', function() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match.');
            } else {
                confirmPassword.setCustomValidity('');
            }
        });
    });
</script>

<jsp:include page="/WEB-INF/templates/footer.jsp" />