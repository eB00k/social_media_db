-- Selects the tables:
SELECT *
FROM users; -- DONE

SELECT *
FROM user_details; -- DONE

SELECT *
FROM follows; -- DONE

SELECT *
FROM messages; -- DONE

SELECT *
FROM post_types; -- DONE

SELECT *
FROM posts; -- DONE

SELECT *
FROM post_medias; -- DONE

SELECT *
FROM post_media_user_tags; -- DONE

SELECT *
FROM saved_posts; -- DONE

SELECT *
FROM comments; -- DONE

SELECT *
FROM content_activity; -- DONE

SELECT *
FROM likes_entity; -- DONE

SELECT *
FROM post_likes; -- DONE

SELECT *
FROM comment_likes; -- DONE

/* SELECT QUERIES WITH users AND user_details */

-- Select all users with their profile details:
SELECT u.id AS user_id,
       u.username,
       u.email,
       u.created_date,
       ud.first_name,
       ud.last_name,
       ud.phone_number,
       ud.profile_picture,
       ud.bio,
       ud.website,
       ud.gender,
       ud.birth_date,
       ud.account_privacy
FROM users u
         JOIN user_details ud ON u.id = ud.user_id;

-- Select users who have a public account:
SELECT u.id AS user_id, u.username, u.email, ud.first_name, ud.last_name
FROM users u
         JOIN user_details ud ON u.id = ud.user_id
WHERE ud.account_privacy = TRUE;

-- Select users with a specific gender (e.g., Female):
SELECT u.id AS user_id, u.username, u.email, ud.first_name, ud.last_name, ud.gender
FROM users u
         JOIN user_details ud ON u.id = ud.user_id
WHERE ud.gender = 'Female';

-- Select users along with their profile pictures:
SELECT u.id AS user_id, u.username, u.email, ud.profile_picture
FROM users u
         JOIN user_details ud ON u.id = ud.user_id;

-- Select users who have a specific keyword in their bio:
SELECT u.id AS user_id, u.username, u.email, ud.first_name, ud.last_name, ud.bio
FROM users u
         JOIN user_details ud ON u.id = ud.user_id
WHERE ud.bio LIKE '%Hello%';

-- Select users along with their birth dates, sorted by birth date:
SELECT u.id AS user_id, u.username, u.email, ud.first_name, ud.last_name, ud.birth_date
FROM users u
         JOIN user_details ud ON u.id = ud.user_id
ORDER BY ud.birth_date;

-- Select the most recently created users along with their profile details:
SELECT u.id AS user_id,
       u.username,
       u.email,
       u.created_date,
       ud.first_name,
       ud.last_name,
       ud.phone_number,
       ud.profile_picture,
       ud.bio,
       ud.website,
       ud.gender,
       ud.birth_date,
       ud.account_privacy
FROM users u
         JOIN user_details ud ON u.id = ud.user_id
ORDER BY u.created_date DESC
LIMIT 10;

-- Select all posts with their authors' usernames and profile details:
SELECT p.id AS post_id,
       p.caption,
       p.created_date,
       u.username,
       u.email,
       ud.first_name,
       ud.last_name,
       ud.profile_picture
FROM posts p
         JOIN users u ON p.user_id = u.id
         JOIN user_details ud ON u.id = ud.user_id;

-- Select all posts along with their post types:
SELECT p.id    AS post_id,
       p.caption,
       pt.name AS post_type,
       p.created_date
FROM posts p
         JOIN post_types pt ON p.post_type_id = pt.id;

-- Select posts created by a specific user (e.g., user with ID 1):
SELECT p.id AS post_id,
       p.caption,
       p.created_date,
       u.username,
       u.email
FROM posts p
         JOIN users u ON p.user_id = u.id
WHERE p.user_id = 1;

-- Select all users with their total number of posts:
SELECT u.id        AS user_id,
       u.username,
       u.email,
       COUNT(p.id) AS post_count
FROM users u
         JOIN posts p ON u.id = p.user_id
GROUP BY u.id;

-- -- List all followers of a specific user:
SELECT u.username AS followed_username,
       f.status,
       f.created_date
FROM follows f
         JOIN
     users u ON f.followed_user_id = u.id
WHERE f.following_user_id = (SELECT id FROM users WHERE username = 'john_doe');

-- List all users followed by a specific user:
SELECT u.username AS following_username,
       f.status,
       f.created_date
FROM follows f
         JOIN
     users u ON f.following_user_id = u.id
         JOIN
     user_details ud ON f.following_user_id = ud.user_id
WHERE f.followed_user_id = (SELECT id FROM users WHERE username = 'john_doe');

-- List all follow requests pending approval
SELECT u.username AS follower_username,
       f.status,
       f.created_date
FROM follows f
         JOIN
     users u ON f.following_user_id = u.id
WHERE f.status = 'Pending';

-- Select the user with the most followers (top = 3):
SELECT u.username AS user_with_most_followers,
       COUNT(*)   AS follower_count
FROM users u
         JOIN
     follows f ON u.id = f.followed_user_id
GROUP BY u.username
ORDER BY follower_count DESC
LIMIT 3;

-- Retrieve all tags on a specific post media:
SELECT pm.media_file,
       u.username AS tagged_user,
       p.user_id  AS post_creator,
       pt.x_coordinate,
       pt.y_coordinate
FROM post_media_user_tags pt
         JOIN
     post_medias pm ON pt.post_media_id = pm.id
         JOIN
     users u ON pt.user_id = u.id
         JOIN
     posts p ON pm.post_id = p.id
WHERE pm.id = 4;
-- Replace with the specific post_media_id

-- Retrieve all tags made by a specific user:
SELECT u.username AS tagged_user,
       pm.media_file,
       pt.x_coordinate,
       pt.y_coordinate
FROM post_media_user_tags pt
         JOIN
     post_medias pm ON pt.post_media_id = pm.id
         JOIN
     users u ON pt.user_id = u.id
WHERE pt.user_id = 1; -- Replace with the specific user_id

-- Select Messages Between Two Users:
SELECT * FROM messages
WHERE (sender_id = 1 AND receiver_id = 2)
   OR (sender_id = 2 AND receiver_id = 1);

-- Select the Most Recent Message for Each User:
SELECT DISTINCT ON (receiver_id) *
FROM messages
ORDER BY receiver_id, created_date DESC;

-- Count of Messages Sent by Each User:
SELECT sender_id, COUNT(*) AS message_count
FROM messages
GROUP BY sender_id
ORDER BY message_count DESC;

-- Count of Messages Received by Each User:
SELECT receiver_id, COUNT(*) AS message_count
FROM messages
GROUP BY receiver_id
ORDER BY message_count DESC;

-- Messages Sent within a Specific Date Range:
SELECT * FROM messages
WHERE created_date BETWEEN '2024-01-10' AND '2024-01-15';

-- Select Messages with Specific Keywords:
SELECT * FROM messages
WHERE content ILIKE '%project%';

-- Retrieve All Posts Saved by a Specific User
SELECT sp.id AS saved_id, sp.created_date, p.caption, u.username AS saved_by
FROM saved_posts sp
JOIN posts p ON sp.post_id = p.id
JOIN users u ON sp.user_id = u.id
WHERE sp.user_id = 1;  -- Replace 1 with the user_id you're interested in

-- Get the Number of Posts Saved by Each User
SELECT u.username, COUNT(sp.id) AS saved_posts_count
FROM saved_posts sp
JOIN users u ON sp.user_id = u.id
GROUP BY u.username
ORDER BY saved_posts_count DESC;

-- Find the Most Saved Post:
SELECT p.id AS post_id, p.caption, COUNT(sp.id) AS times_saved
FROM saved_posts sp
JOIN posts p ON sp.post_id = p.id
GROUP BY p.id
ORDER BY times_saved DESC
LIMIT 1;

-- List All Users Who Saved a Specific Post:
SELECT u.username, sp.created_date
FROM saved_posts sp
JOIN users u ON sp.user_id = u.id
WHERE sp.post_id = 3;


-- Select comments and their replies:
SELECT c.id AS comment_id, c.comment, u.username AS commenter, r.id AS reply_id, r.comment AS reply, ru.username AS replier
FROM comments c
LEFT JOIN comments r ON c.id = r.comment_replied_to_id
LEFT JOIN users u ON c.user_id = u.id
LEFT JOIN users ru ON r.user_id = ru.id
WHERE c.comment_replied_to_id IS NULL; -- This ensures we only get top-level comments

-- Select the number of comments on each post:
SELECT post_id, COUNT(*) AS comment_count
FROM comments
GROUP BY post_id;

-- Select comments with a specific keyword:
SELECT * FROM comments
WHERE comment ILIKE '%great%'; -- Replace with the desired keyword

-- Select comments on posts by a specific user:
SELECT c.id AS comment_id, c.comment, c.created_date, p.caption, u.username AS post_creator
FROM comments c
JOIN posts p ON c.post_id = p.id
JOIN users u ON p.user_id = u.id
WHERE u.id = 1; -- Replace with the specific user_id


