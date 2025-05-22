-- Check if Problem table is empty
SELECT COUNT(*) FROM Problem;

-- Insert sample problem data if needed
INSERT INTO Problem (ID, Title, Acceptance, isPremium, Difficulty, Question_Link, Solution_Link)
SELECT * FROM (
    SELECT 1 as ID, 'Two Sum' as Title, 75.5 as Acceptance, 0 as isPremium, 'Easy' as Difficulty, 
           'https://example.com/problems/two-sum' as Question_Link, 
           'https://example.com/solutions/two-sum' as Solution_Link
    UNION ALL
    SELECT 2, 'Valid Parentheses', 68.3, 0, 'Easy', 
           'https://example.com/problems/valid-parentheses', 
           'https://example.com/solutions/valid-parentheses'
    UNION ALL
    SELECT 3, 'Merge Two Sorted Lists', 79.2, 0, 'Easy', 
           'https://example.com/problems/merge-two-sorted-lists', 
           'https://example.com/solutions/merge-two-sorted-lists'
    UNION ALL
    SELECT 4, 'Best Time to Buy and Sell Stock', 72.1, 0, 'Easy', 
           'https://example.com/problems/best-time-to-buy-and-sell-stock', 
           'https://example.com/solutions/best-time-to-buy-and-sell-stock'
    UNION ALL
    SELECT 5, 'Valid Palindrome', 66.9, 0, 'Easy', 
           'https://example.com/problems/valid-palindrome', 
           'https://example.com/solutions/valid-palindrome'
    UNION ALL
    SELECT 6, 'Linked List Cycle', 71.5, 0, 'Easy', 
           'https://example.com/problems/linked-list-cycle', 
           'https://example.com/solutions/linked-list-cycle'
    UNION ALL
    SELECT 7, 'Maximum Subarray', 68.7, 0, 'Easy', 
           'https://example.com/problems/maximum-subarray', 
           'https://example.com/solutions/maximum-subarray'
    UNION ALL
    SELECT 8, 'Add Two Numbers', 59.5, 0, 'Medium', 
           'https://example.com/problems/add-two-numbers', 
           'https://example.com/solutions/add-two-numbers'
    UNION ALL
    SELECT 9, 'Longest Substring Without Repeating Characters', 53.2, 0, 'Medium', 
           'https://example.com/problems/longest-substring-without-repeating-characters', 
           'https://example.com/solutions/longest-substring-without-repeating-characters'
    UNION ALL
    SELECT 10, 'LRU Cache', 48.7, 0, 'Medium', 
           'https://example.com/problems/lru-cache', 
           'https://example.com/solutions/lru-cache'
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM Problem WHERE ID = tmp.ID
);

-- Query to verify the data
SELECT * FROM Problem; 