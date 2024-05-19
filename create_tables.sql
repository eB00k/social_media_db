-- Social Media Platform Database Schema

/*
This database schema is designed to support a social media platform resembling Instagram.
It includes tables for users, user details, follow relationships, messages, posts, comments, likes, and saved posts.
*/

-- Drop tables
DROP TABLE IF EXISTS comment_likes CASCADE;
DROP TABLE IF EXISTS post_likes CASCADE;
DROP TABLE IF EXISTS likes_entity CASCADE;
DROP TABLE IF EXISTS content_activity CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS saved_posts CASCADE;
DROP TABLE IF EXISTS post_media_user_tags CASCADE;
DROP TABLE IF EXISTS post_medias CASCADE;
DROP TABLE IF EXISTS posts CASCADE;
DROP TABLE IF EXISTS post_types CASCADE;
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS follows CASCADE;
DROP TABLE IF EXISTS user_details CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Define custom ENUM types for gender, follow status, and reaction target
CREATE TYPE gender_enum AS ENUM ('Male', 'Female');
CREATE TYPE follow_status_enum AS ENUM ('Pending', 'Approved', 'Rejected');
CREATE TYPE reaction_to_enum AS ENUM ('Post', 'Comment');

-- Define custom ENUM types for gender, follow status, and reaction target
CREATE TYPE gender_enum AS ENUM ('Male', 'Female');
CREATE TYPE follow_status_enum AS ENUM ('Pending', 'Approved', 'Rejected');
CREATE TYPE reaction_to_enum AS ENUM ('Post', 'Comment');

CREATE OR REPLACE FUNCTION create_social_media_tables() RETURNS void AS
$$
BEGIN
    -- users table: Stores user account information
    CREATE TABLE IF NOT EXISTS users
    (
        id              SERIAL PRIMARY KEY,
        username        VARCHAR(50)  NOT NULL,                     -- username for login
        email           VARCHAR(255) NOT NULL,                     -- Unique email address for login
        password        VARCHAR(100) NOT NULL,                     -- Hashed password for authentication
        created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,       -- Timestamp of user registration
        last_login_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,       -- Timestamp of user's last login
        UNIQUE (username, email),
        CONSTRAINT password_strength CHECK (length(password) >= 8) -- Enforces password strength
    );

    -- user_details table: Stores additional user profile information
    CREATE TABLE IF NOT EXISTS user_details
    (
        id              SERIAL PRIMARY KEY,
        first_name      VARCHAR(50) NOT NULL,                         -- User's first name
        last_name       VARCHAR(50) NOT NULL,                         -- User's last name
        phone_number    VARCHAR(20),                                  -- User's phone number (optional)
        profile_picture VARCHAR(255),                                 -- URL or path to the user's profile picture
        bio             TEXT,                                         -- User's biography or description
        website         VARCHAR(255),                                 -- User's website URL
        gender          gender_enum,                                  -- User's gender (Male/Female)
        birth_date      DATE,                                         -- User's date of birth
        account_privacy BOOLEAN DEFAULT TRUE,                         -- Account privacy setting (True for public, False for private)
        user_id         INTEGER UNIQUE,                               -- Foreign key referencing the corresponding user in the users table
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE -- Ensure data consistency with CASCADE delete
    );

    -- follows table: Manages user follow relationships
    CREATE TABLE IF NOT EXISTS follows
    (
        id                SERIAL PRIMARY KEY,
        following_user_id INTEGER NOT NULL,                     -- ID of the user who is following
        followed_user_id  INTEGER NOT NULL,                     -- ID of the user who is being followed
        status            follow_status_enum DEFAULT 'Pending', -- Status of the follow relationship (Pending/Approved/Rejected)
        created_date      TIMESTAMP          DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (following_user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (followed_user_id) REFERENCES users (id) ON DELETE CASCADE
    );

    -- messages table: Stores messages between users
    CREATE TABLE IF NOT EXISTS messages
    (
        id           SERIAL PRIMARY KEY,
        content      TEXT,                    -- Message content
        seen         BOOLEAN   DEFAULT FALSE, -- Flag indicating if the message has been seen by the recipient
        sender_id    INTEGER NOT NULL,        -- ID of the user who sent the message
        receiver_id  INTEGER NOT NULL,        -- ID of the user who received the message
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (sender_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (receiver_id) REFERENCES users (id) ON DELETE CASCADE
    );

    -- post_types table: Defines types of posts (e.g., 'story', 'profile')
    CREATE TABLE IF NOT EXISTS post_types
    (
        id   SERIAL PRIMARY KEY,
        name VARCHAR(50) UNIQUE -- Name of the post type (e.g., 'story', 'profile')
    );

    -- posts table: Stores post information
    CREATE TABLE IF NOT EXISTS posts
    (
        id           SERIAL PRIMARY KEY,
        caption      TEXT,             -- Caption or description of the post
        post_type_id INTEGER NOT NULL, -- ID of the post type
        user_id      INTEGER NOT NULL, -- ID of the user who created the post
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_type_id) REFERENCES post_types (id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    );

    -- post_medias table: Stores media files related to posts
    CREATE TABLE IF NOT EXISTS post_medias
    (
        id         SERIAL PRIMARY KEY,
        media_file VARCHAR(255),     -- URL or path to the media file
        position   INTEGER,          -- Order in which the media appears in the post
        longitude  FLOAT,            -- Longitude coordinate for geotagging (optional)
        latitude   FLOAT,            -- Latitude coordinate for geotagging (optional)
        post_id    INTEGER NOT NULL, -- ID of the post associated with the media
        FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE
    );

    -- post_media_user_tags table: Stores user tags on media files
    CREATE TABLE IF NOT EXISTS post_media_user_tags
    (
        id            SERIAL PRIMARY KEY,
        x_coordinate  INTEGER,          -- X-coordinate of the tag position
        y_coordinate  INTEGER,          -- Y-coordinate of the tag position
        post_media_id INTEGER NOT NULL, -- ID of the post media associated with the tag
        user_id       INTEGER NOT NULL, -- ID of the user who is tagged
        FOREIGN KEY (post_media_id) REFERENCES post_medias (id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    );

    -- saved_posts table: Manages saved posts by users
    CREATE TABLE IF NOT EXISTS saved_posts
    (
        id           SERIAL PRIMARY KEY,
        post_id      INTEGER NOT NULL, -- ID of the post being saved
        user_id      INTEGER NOT NULL, -- ID of the user who saved the post
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    );

    -- comments table: Stores comments on posts
    CREATE TABLE IF NOT EXISTS comments
    (
        id                    SERIAL PRIMARY KEY,
        comment               TEXT,             -- Text of the comment
        post_id               INTEGER NOT NULL, -- ID of the post to which the comment belongs
        user_id               INTEGER NOT NULL, -- ID of the user who posted the comment
        comment_replied_to_id INTEGER,          -- ID of the comment to which this comment is a reply (optional)
        created_date          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (comment_replied_to_id) REFERENCES comments (id) ON DELETE CASCADE
    );

    -- content_activity table: Manages number of likes that post or comment has
    CREATE TABLE IF NOT EXISTS content_activity
    (
        parent_id INTEGER PRIMARY KEY, -- ID of the post or comment
        count     INTEGER DEFAULT 0
    );

    -- Create a new likes table
    CREATE TABLE IF NOT EXISTS likes
    (
        id           SERIAL PRIMARY KEY,
        user_id      INTEGER          NOT NULL,
        entity_id    INTEGER          NOT NULL,
        entity_type  reaction_to_enum NOT NULL, -- 'Post' or 'Comment'
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        CHECK (entity_type IN ('Post', 'Comment'))
    );

    RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT create_social_media_tables();


-- Trigger function to increment content_activity counter
CREATE OR REPLACE FUNCTION increment_content_activity_counter()
    RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.entity_type = 'Post' THEN
        -- Increment the counter for the post in the content_activity table
        UPDATE content_activity SET count = count + 1 WHERE parent_id = NEW.entity_id;
    ELSIF NEW.entity_type = 'Comment' THEN
        -- Increment the counter for the comment in the content_activity table
        UPDATE content_activity SET count = count + 1 WHERE parent_id = NEW.entity_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger function to decrement content_activity counter
CREATE OR REPLACE FUNCTION decrement_content_activity_counter()
    RETURNS TRIGGER AS
$$
BEGIN
    IF OLD.entity_type = 'Post' THEN
        -- Decrement the counter for the post in the content_activity table
        UPDATE content_activity SET count = count - 1 WHERE parent_id = OLD.entity_id;
    ELSIF OLD.entity_type = 'Comment' THEN
        -- Decrement the counter for the comment in the content_activity table
        UPDATE content_activity SET count = count - 1 WHERE parent_id = OLD.entity_id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Create Triggers
CREATE TRIGGER update_content_activity_counter
    AFTER INSERT
    ON likes
    FOR EACH ROW
EXECUTE FUNCTION increment_content_activity_counter();

CREATE TRIGGER update_content_activity_counter_delete
    AFTER DELETE
    ON likes
    FOR EACH ROW
EXECUTE FUNCTION decrement_content_activity_counter();


/* ------ SELECT TABLES ------ */

SELECT *
FROM users;

SELECT *
FROM user_details;

SELECT *
FROM follows;

SELECT *
FROM messages;

SELECT *
FROM post_types;

SELECT *
FROM posts;

SELECT *
FROM post_medias;

SELECT *
FROM post_media_user_tags;

SELECT *
FROM saved_posts;

SELECT *
FROM comments;

SELECT *
FROM content_activity;

SELECT *
FROM likes;