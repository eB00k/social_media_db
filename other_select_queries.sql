-- Finding users with the most followers
SELECT followed_user_id, COUNT(*) AS follower_count
FROM follows
WHERE status = 'Approved' -- Considering only approved follows
GROUP BY followed_user_id
ORDER BY follower_count DESC
LIMIT 5; -- Getting the top 5 users with most followers

-- Finding users who are following the most people
SELECT following_user_id, COUNT(*) AS following_count
FROM follows
WHERE status = 'Approved' -- Consider only approved follows
GROUP BY following_user_id
ORDER BY following_count DESC
LIMIT 5; -- Get the top 5 users who are following the most people

