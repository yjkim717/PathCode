package com.pathcode.servlet;

import com.pathcode.dao.UserDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
  private UserDAO userDAO = new UserDAO();

  // Handles GET requests (Read users)
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    List<String> users = userDAO.getUsers();
    request.setAttribute("users", users);
    request.getRequestDispatcher("views/users.jsp").forward(request, response);
  }

  // Handles POST requests (Create & Delete users)
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String action = request.getParameter("action");

    if ("create".equals(action)) {
      String username = request.getParameter("username");
      String email = request.getParameter("email");
      userDAO.createUser(username, email);
    } else if ("delete".equals(action)) {
      int userId = Integer.parseInt(request.getParameter("userId"));
      userDAO.deleteUser(userId);
    }

    response.sendRedirect("users");
  }
}
