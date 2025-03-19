package com.pathcode.servlet;
import com.pathcode.dao.DashboardDAO;
import com.pathcode.model.Dashboard;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
  private DashboardDAO dashboardDAO = new DashboardDAO();

  // Handles GET requests (Display user dashboard)
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    int userId = Integer.parseInt(request.getParameter("userId"));
    Map<String, Object> dashboardData = dashboardDAO.getDashboardData(userId);

    request.setAttribute("dashboardData", dashboardData);
    request.getRequestDispatcher("views/dashboard.jsp").forward(request, response);
  }
}
