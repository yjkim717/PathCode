-- Insert recommendation data
INSERT INTO Recommendation (User_ID, Problem_ID, RecommendedDate, ConfidenceScore, CreatedDate)
VALUES 
(1, 3, NOW(), 87.5, NOW()),
(1, 5, NOW(), 92.3, NOW()),
(2, 4, NOW(), 78.6, NOW()),
(2, 6, NOW(), 65.2, NOW()),
(3, 2, NOW(), 89.7, NOW()),
(3, 7, NOW(), 72.4, NOW()),
(4, 5, NOW(), 94.8, NOW()),
(4, 8, NOW(), 83.1, NOW()),
(5, 4, NOW(), 76.5, NOW()),
(5, 9, NOW(), 90.2, NOW());

-- Query to verify the data
SELECT 
    r.ID, 
    r.User_ID, 
    u.Username,
    r.Problem_ID, 
    p.Title as ProblemTitle,
    ROUND(r.ConfidenceScore, 1) as ConfidenceScore,
    r.RecommendedDate,
    r.CreatedDate
FROM 
    Recommendation r
    LEFT JOIN User u ON r.User_ID = u.ID
    LEFT JOIN Problem p ON r.Problem_ID = p.ID
ORDER BY 
    r.ID; 