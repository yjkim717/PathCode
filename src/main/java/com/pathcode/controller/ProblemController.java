package com.pathcode.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pathcode.dao.ProblemDAO;
import com.pathcode.dao.UserProgressDAO;
import com.pathcode.dao.impl.ProblemDAOImpl;
import com.pathcode.dao.impl.UserProgressDAOImpl;
import com.pathcode.model.Problem;
import com.pathcode.model.UserProgress;

//@WebServlet("/problem/*")
public class ProblemController extends HttpServlet {

    private ProblemDAO problemDAO;

    public void init() {
        problemDAO = new ProblemDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo(); // e.g. /view, /new
        if (action == null) action = "/list";

        switch (action) {
            case "/view":
                showProblemView(request, response);
                break;
            case "/new":
                showProblemForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteProblem(request, response);
                break;
            case "/list":
            default:
                listProblems(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        switch (action) {
            case "/insert":
                insertProblem(request, response);
                break;
            case "/update":
                updateProblem(request, response);
                break;
        }
    }

    private void listProblems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Problem> problems = problemDAO.getAllProblems();
        
        // Debug log: print problem list details
        System.out.println("Problem list size: " + (problems != null ? problems.size() : "null"));
        if (problems != null) {
            for (Problem p : problems) {
                System.out.println("Problem in controller: ID=" + p.getProblemId() + ", Title=" + p.getTitle());
            }
        }
        
        request.setAttribute("problems", problems);

        // Get userId from session instead of hardcoding
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userID");
        
        System.out.println("Current user ID from session: " + userId);
        
        if (userId != null) {
            UserProgressDAO progressDAO = new UserProgressDAOImpl();
            List<UserProgress> progressList = progressDAO.getAllProgressForUser(userId);

            Map<Integer, String> statusMap = new HashMap<>();
            for (UserProgress progress : progressList) {
                if (progress.isSolved()) {
                    statusMap.put(progress.getProblemId(), "solved");
                } else {
                    statusMap.put(progress.getProblemId(), "inprogress");
                }
            }
            request.setAttribute("progressMap", statusMap);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/problem/problem-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showProblemView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Problem problem = problemDAO.getProblemById(id);
        request.setAttribute("problem", problem);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/problem/problem-view.jsp");
        dispatcher.forward(request, response);
    }

    private void showProblemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("problem", null);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/problem/problem-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Problem problem = problemDAO.getProblemById(id);
        request.setAttribute("problem", problem);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/problem/problem-form.jsp");
        dispatcher.forward(request, response);
    }

    private void insertProblem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Problem problem = buildProblemFromRequest(request);
        problemDAO.insertProblem(problem);
        response.sendRedirect(request.getContextPath() + "/problem/list");
    }

    private void updateProblem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Problem problem = buildProblemFromRequest(request);
        problem.setProblemId(Integer.parseInt(request.getParameter("problemId")));
        problemDAO.updateProblem(problem);
        response.sendRedirect(request.getContextPath() + "/problem/list");
    }

    private void deleteProblem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        problemDAO.deleteProblem(id);
        response.sendRedirect(request.getContextPath() + "/problem/list");
    }

    private Problem buildProblemFromRequest(HttpServletRequest request) {
        Problem problem = new Problem();
        problem.setTitle(request.getParameter("title"));
        problem.setDifficulty(request.getParameter("difficulty"));
        problem.setAcceptance(Double.parseDouble(request.getParameter("acceptance")));
        problem.setPremium(request.getParameter("isPremium") != null);
        problem.setQuestionLink(request.getParameter("questionLink"));
        problem.setSolutionLink(request.getParameter("solutionLink"));
        return problem;
    }
}
