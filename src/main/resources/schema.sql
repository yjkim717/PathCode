-- Create Dashboard table if it doesn't exist
CREATE TABLE IF NOT EXISTS Dashboard (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Total_Problems_Attempted INT DEFAULT 0,
    Total_Problems_Solved INT DEFAULT 0,
    Success_Rate DOUBLE DEFAULT 0.0,
    Average_Time_Per_Problem INT DEFAULT 0,
    Current_Stage INT DEFAULT 1,
    Problems_In_Progress INT DEFAULT 0,
    Last_Active_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Weekly_Solved_Count INT DEFAULT 0,
    Monthly_Solved_Count INT DEFAULT 0,
    Favorite_Tag_ID INT NULL,
    Current_Streak INT DEFAULT 0,
    Longest_Streak INT DEFAULT 0
);

-- Add index on User_ID for faster lookups
CREATE INDEX IF NOT EXISTS idx_dashboard_user_id ON Dashboard (User_ID);

-- Create Recommendation table if it doesn't exist
CREATE TABLE IF NOT EXISTS Recommendation (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Problem_ID INT NOT NULL,
    RecommendedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ConfidenceScore DOUBLE DEFAULT 75.0,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add indexes for faster lookups
CREATE INDEX IF NOT EXISTS idx_recommendation_user_id ON Recommendation (User_ID);
CREATE INDEX IF NOT EXISTS idx_recommendation_problem_id ON Recommendation (Problem_ID); 