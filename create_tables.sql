-- Social Media Platform Database Schema

/*
This database schema is designed to support a social media platform resembling Instagram.
It includes tables for users, user details, follow relationships, messages, posts, comments, reactions, and saved posts.
*/

-- Define custom ENUM types for gender, follow status, and reaction target

CREATE TYPE gender_enum AS ENUM('Male', 'Female');
CREATE TYPE follow_status_enum AS ENUM('Pending', 'Approved', 'Rejected');
-- CREATE TYPE reaction_to_enum AS ENUM('Post', 'Comment');

-- users table: Stores user account information
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL, -- username for login
    email VARCHAR(255) NOT NULL, -- Unique email address for login
    password VARCHAR(100) NOT NULL, -- Hashed password for authentication
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of user registration
    last_login_date TIMESTAMP, -- Timestamp of user's last login
    UNIQUE(username, email),
    CONSTRAINT password_strength CHECK (length(password) >= 8) -- Enforces password strength
);

-- user_details table: Stores additional user profile information
CREATE TABLE user_details (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL, -- User's first name
    last_name VARCHAR(50) NOT NULL, -- User's last name
    phone_number VARCHAR(20), -- User's phone number (optional)
    profile_picture VARCHAR(255), -- URL or path to the user's profile picture
    bio TEXT, -- User's biography or description
    website VARCHAR(255), -- User's website URL
    gender gender_enum, -- User's gender (Male/Female)
    birth_date DATE, -- User's date of birth
    account_privacy BOOLEAN DEFAULT TRUE, -- Account privacy setting (True for public, False for private)
    user_id INTEGER UNIQUE, -- Foreign key referencing the corresponding user in the users table
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE -- Ensure data consistency with CASCADE delete
);

-- follows table: Manages user follow relationships
CREATE TABLE follows (
    id SERIAL PRIMARY KEY,
    following_user_id INTEGER NOT NULL, -- ID of the user who is following
    followed_user_id INTEGER NOT NULL, -- ID of the user who is being followed
    status follow_status_enum, -- Status of the follow relationship (Pending/Approved/Rejected)
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (following_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (followed_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- messages table: Stores messages between users
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    content TEXT, -- Message content
    seen BOOLEAN DEFAULT FALSE, -- Flag indicating if the message has been seen by the recipient
    sender_id INTEGER NOT NULL, -- ID of the user who sent the message
    receiver_id INTEGER NOT NULL, -- ID of the user who received the message
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

-- post_types table: Defines types of posts (e.g., 'story', 'profile')
CREATE TABLE post_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE -- Name of the post type (e.g., 'story', 'profile')
);

-- posts table: Stores post information
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    caption TEXT, -- Caption or description of the post
    post_type_id INTEGER NOT NULL, -- ID of the post type
    user_id INTEGER NOT NULL, -- ID of the user who created the post
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_type_id) REFERENCES post_types(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- post_medias table: Stores media files related to posts
CREATE TABLE post_medias (
    id SERIAL PRIMARY KEY,
    media_file VARCHAR(255), -- URL or path to the media file
    position INTEGER, -- Order in which the media appears in the post
    longitude FLOAT, -- Longitude coordinate for geotagging (optional)
    latitude FLOAT, -- Latitude coordinate for geotagging (optional)
    post_id INTEGER NOT NULL, -- ID of the post associated with the media
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- post_media_user_tags table: Stores user tags on media files
CREATE TABLE post_media_user_tags (
    id SERIAL PRIMARY KEY,
    x_coordinate INTEGER, -- X-coordinate of the tag position
    y_coordinate INTEGER, -- Y-coordinate of the tag position
    post_media_id INTEGER NOT NULL, -- ID of the post media associated with the tag
    user_id INTEGER NOT NULL, -- ID of the user who is tagged
    FOREIGN KEY (post_media_id) REFERENCES post_medias(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- saved_posts table: Manages saved posts by users
CREATE TABLE saved_posts (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL, -- ID of the post being saved
    user_id INTEGER NOT NULL, -- ID of the user who saved the post
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- comments table: Stores comments on posts
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    comment TEXT, -- Text of the comment
    post_id INTEGER NOT NULL, -- ID of the post to which the comment belongs
    user_id INTEGER NOT NULL, -- ID of the user who posted the comment
    comment_replied_to_id INT, -- ID of the comment to which this comment is a reply (optional)
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (comment_replied_to_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- content_activity table: Manages number of likes that post or comment has
CREATE TABLE content_activity (
    parent_id INTEGER PRIMARY KEY, -- ID of the post or comment
    count INTEGER DEFAULT 0
);

-- likes_entity table: Parent table for likes
CREATE TABLE likes_entity (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL, -- ID of the user who reacted
    entity_id INTEGER NOT NULL, -- ID of the post or comment being liked
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- post_likes table: Stores likes on posts
CREATE TABLE post_likes (
    CONSTRAINT post_likes_fk FOREIGN KEY (entity_id) REFERENCES posts(id)
) INHERITS (likes_entity);

-- comment_likes table: Stores likes on comments
CREATE TABLE comment_likes (
    CONSTRAINT comment_likes_fk FOREIGN KEY (entity_id) REFERENCES comments(id)
) INHERITS (likes_entity);


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

-- Trigger function to increment content_activity counter
CREATE OR REPLACE FUNCTION increment_content_activity_counter()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'post_likes' THEN
        -- Increment the counter for the post in the content_activity table
        UPDATE content_activity SET count = count + 1 WHERE parent_id = NEW.entity_id;
    ELSIF TG_TABLE_NAME = 'comment_likes' THEN
        -- Increment the counter for the comment in the content_activity table
        UPDATE content_activity SET count = count + 1 WHERE parent_id = NEW.entity_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_content_activity_counter
AFTER INSERT ON post_likes
FOR EACH ROW
EXECUTE FUNCTION increment_content_activity_counter();

CREATE TRIGGER update_content_activity_counter_comment
AFTER INSERT ON comment_likes
FOR EACH ROW
EXECUTE FUNCTION increment_content_activity_counter();

-- Trigger function to decrement content_activity counter
CREATE OR REPLACE FUNCTION decrement_content_activity_counter()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'post_likes' THEN
        -- Decrement the counter for the post in the content_activity table
        UPDATE content_activity SET count = count - 1 WHERE parent_id = OLD.entity_id;
    ELSIF TG_TABLE_NAME = 'comment_likes' THEN
        -- Decrement the counter for the comment in the content_activity table
        UPDATE content_activity SET count = count - 1 WHERE parent_id = OLD.entity_id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger to execute the decrement_content_activity_counter function after a like is deleted from post_likes
CREATE TRIGGER update_content_activity_counter_delete_post
AFTER DELETE ON post_likes
FOR EACH ROW
EXECUTE FUNCTION decrement_content_activity_counter();

-- Trigger to execute the decrement_content_activity_counter function after a like is deleted from comment_likes
CREATE TRIGGER update_content_activity_counter_delete_comment
AFTER DELETE ON comment_likes
FOR EACH ROW
EXECUTE FUNCTION decrement_content_activity_counter();

-- Generate sample data for the content_activity table
INSERT INTO content_activity (parent_id, count)
SELECT id, 0
FROM posts
UNION
SELECT id, 0
FROM comments;

-- Generate sample data for the post_likes table
INSERT INTO post_likes (user_id, entity_id, created_date)
SELECT
    floor(random() * 100) + 1, -- Random user_id
    id, -- Random post id
    CURRENT_TIMESTAMP - INTERVAL '1 day' * (random() * 365)::integer
FROM posts
ORDER BY random()
LIMIT 1000; -- Limit the number of likes generated for posts

-- Generate sample data for the comment_likes table
INSERT INTO comment_likes (user_id, entity_id, created_date)
SELECT
    floor(random() * 100) + 1, -- Random user_id
    id, -- Random comment id
    CURRENT_TIMESTAMP - INTERVAL '1 day' * (random() * 365)::integer
FROM comments
ORDER BY random()
LIMIT 1000; -- Limit the number of likes generated for comments;


/* ------ OTHER SELECT QUERIES ------ */

SELECT * FROM users;
SELECT * FROM user_details;
SELECT * FROM follows;
SELECT * FROM messages;
SELECT * FROM post_types;
SELECT * FROM posts;
SELECT * FROM post_medias;
SELECT * FROM post_media_user_tags;
SELECT * FROM saved_posts;
SELECT * FROM comments;
SELECT * FROM content_activity;
SELECT * FROM likes_entity;
SELECT * FROM post_likes;
SELECT * FROM comment_likes;