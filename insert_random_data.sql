/* ------ SETTING DATA ------ */

-- Generate sample data for the users table
INSERT INTO users (username, email, password, created_date, last_login_date)
SELECT
    'user' || id,
    'user' || id || '@example.com',
    'password' || id,
    CURRENT_TIMESTAMP - INTERVAL '1 day' * (random() * 365)::integer,
    CURRENT_TIMESTAMP - INTERVAL '1 hour' * (random() * 23)::integer
FROM generate_series(1, 100) AS id;

-- Generate sample data for the user_details table
INSERT INTO user_details(first_name, last_name, phone_number, profile_picture, bio, website, gender, birth_date, account_privacy, user_id)
SELECT
    'User' || id,
    'Lastname' || id,
    '+1234567890',
    'https://example.com/profile' || id || '.jpg',
    'Bio for user ' || id,
    'https://example.com/user' || id,
    CASE WHEN random() < 0.5 THEN 'Male'::gender_enum ELSE 'Female'::gender_enum END,
    CURRENT_DATE - INTERVAL '365 day' * (random() * 60)::integer,
    CASE WHEN random() < 0.5 THEN true else false END,
    id
FROM generate_series(1, 100) as id;

-- Generate sample data for the follows table
INSERT INTO follows (following_user_id, followed_user_id, status, created_date)
SELECT
    floor(random() * 100) + 1,
    floor(random() * 100) + 1,
    CASE
        WHEN random() < 0.7 THEN 'Approved'::follow_status_enum
        WHEN random() < 0.9 THEN 'Pending'::follow_status_enum
        ELSE 'Rejected'::follow_status_enum
    END,
    CURRENT_TIMESTAMP - INTERVAL '1 day' * (random() * 365)::integer
FROM generate_series(1, 500) as id;

-- Generate sample data for the messages table
INSERT INTO messages (content, seen, sender_id, receiver_id, created_date)
SELECT
    'Message content from user ' || sender_id || ' to user ' || receiver_id,
    CASE WHEN random() < 0.8 THEN true ELSE false END,
    sender_id,
    receiver_id,
    CURRENT_TIMESTAMP - INTERVAL '1 day' * (random() * 365)::integer
FROM (
    SELECT
        floor(random() * 100) + 1 AS sender_id,
        floor(random() * 100) + 1 AS receiver_id
    FROM generate_series(1, 1000) as id
) AS subquery;

-- Generate sample data for the post_types table
INSERT INTO post_types (name)
VALUES
    ('Story'),
    ('Profile');

-- Generate sample data for the posts table
INSERT INTO posts (caption, post_type_id, user_id, created_date)
SELECT
    'Caption for post ' || id,
    floor(random() * 2) + 1,
    floor(random() * 100) + 1,
    CURRENT_TIMESTAMP - INTERVAL '1' DAY * (random() * 365)::integer
FROM generate_series(1, 200) AS id;

-- Generate sample data for the post_medias table
INSERT INTO post_medias (media_file, position, longitude, latitude, post_id)
SELECT
    'https://example.com/post_media' || id || '.jpg',
    floor(random() * 5) + 1,
    random() * 180 - 90,
    random() * 360 - 180,
    floor(random() * 200) + 1
FROM generate_series(1, 300) AS id;

-- Generate sample data for the post_media_user_tags table
INSERT INTO post_media_user_tags (x_coordinate, y_coordinate, post_media_id, user_id)
SELECT
    floor(random() * 1000) + 1,
    floor(random() * 1000) + 1,
    floor(random() * 300) + 1,
    floor(random() * 100) + 1
FROM generate_series(1, 500) AS id;

-- Generate sample data for the saved_posts table
INSERT INTO saved_posts (post_id, user_id, created_date)
SELECT
    floor(random() * 200) + 1,
    floor(random() * 100) + 1,
    CURRENT_TIMESTAMP - INTERVAL '1' DAY * (random() * 365)::integer
FROM generate_series(1, 400) AS id;

-- Generate sample data for the comments table
INSERT INTO comments (comment, post_id, user_id, comment_replied_to_id, created_date)
SELECT
    'Comment ' || subquery.id || ' on post ' || post_id,
    post_id,
    floor(random() * 100) + 1,
    CASE WHEN random() < 0.5 THEN null ELSE (SELECT id FROM comments ORDER BY random() LIMIT 1) END,
    CURRENT_TIMESTAMP - INTERVAL '1' DAY * (random() * 365)::integer
FROM (
    SELECT
        floor(random() * 200) + 1 as post_id,
        generate_series(1, 500) as id
) AS subquery;

-- Generate sample data for the content_activity table
INSERT INTO content_activity (parent_id, count)
SELECT id, 0
FROM posts
UNION
SELECT id, 0
FROM comments;
