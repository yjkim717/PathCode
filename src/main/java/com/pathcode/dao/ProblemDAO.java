package com.pathcode.dao;

import com.pathcode.model.Problem;
import java.util.List;

public interface ProblemDAO {
    List<Problem> getAllProblems();

    Problem getProblemById(int id);

    void insertProblem(Problem problem);

    void updateProblem(Problem problem);

    void deleteProblem(int id);
}
