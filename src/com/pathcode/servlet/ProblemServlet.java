package com.pathcode.servlet;
import com.pathcode.dao.ProblemDAO;
import com.pathcode.model.Problem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/problems")
public class ProblemServlet extends HttpServlet {
  private ProblemDAO problemDAO = new ProblemDAO();

  // Handles GET requests (Read problems)
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    List<String> problems = problemDAO.getProblems();
    request.setAttribute("problems", problems);
    request.getRequestDispatcher("views/problems.jsp").forward(request, response);
  }

  // Handles POST requests (Create, Update, Delete problems)
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String action = request.getParameter("action");

    if ("create".equals(action)) {
      int id = Integer.parseInt(request.getParameter("id"));
      String title = request.getParameter("title");
      double acceptance = Double.parseDouble(request.getParameter("acceptance"));
      String difficulty = request.getParameter("difficulty");
      String questionLink = request.getParameter("questionLink");
      String solutionLink = request.getParameter("solutionLink");

      problemDAO.createProblem(id, title, acceptance, difficulty, questionLink, solutionLink);
    } else if ("delete".equals(action)) {
      int problemId = Integer.parseInt(request.getParameter("problemId"));
      problemDAO.deleteProblem(problemId);
    }

    response.sendRedirect("problems");
  }
}
