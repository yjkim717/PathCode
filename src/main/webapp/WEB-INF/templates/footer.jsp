    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container position-relative">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4><i class="fas fa-code"></i> PathCode</h4>
                    <p style="color: var(--text-secondary);">A personalized learning platform for coding practice and skill development.</p>
                    <p style="color: var(--text-secondary);">Helping developers master programming one step at a time.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <h4>Quick Links</h4>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white"><i class="fas fa-angle-right mr-2"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/progress/user?userId=${sessionScope.userID}" class="text-white"><i class="fas fa-angle-right mr-2"></i> My Progress</a></li>
                        <li><a href="${pageContext.request.contextPath}/dashboard/view" class="text-white"><i class="fas fa-angle-right mr-2"></i> Dashboards</a></li>
                        <li><a href="${pageContext.request.contextPath}/learning-path/list" class="text-white"><i class="fas fa-angle-right mr-2"></i> Learning Paths</a></li>
                        <li><a href="${pageContext.request.contextPath}/recommendation/list" class="text-white"><i class="fas fa-angle-right mr-2"></i> Recommendations</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h4>Connect With Us</h4>
                    <p style="color: var(--text-secondary);">Follow us on social media for updates and coding tips.</p>
                    <div class="mt-3" style="display: flex; justify-content: center; gap: 15px;">
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-github"></i>
                        </a>
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-linkedin"></i>
                        </a>
                        <a href="#" class="text-white" style="background-color: rgba(255,255,255,0.1); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                            <i class="fab fa-discord"></i>
                        </a>
                    </div>
                </div>
            </div>
            <hr style="border-color: rgba(56, 189, 248, 0.2); margin: 2rem 0;">
            <p style="color: var(--text-secondary);">&copy; 2025 PathCode Learning System. All rights reserved.</p>
        </div>
    </footer>

    <!-- Required Scripts -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/particles.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>
</html> 