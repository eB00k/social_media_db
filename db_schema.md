### Social Media Platform Diagram

https://drawsql.app/teams/dias-3/diagrams/social-media

![alt text](db_diagram.png)

```
-- users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL CHECK (email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'),
    password VARCHAR(100) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login_date TIMESTAMP,
    CONSTRAINT password_strength CHECK (length(password) >= 8) -- password strength constraint
);

-- user_details table
CREATE TABLE user_details (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) not null,
    last_name VARCHAR(50) not null,
    phone_number VARCHAR(20),
    profile_picture VARCHAR(255), -- URL or path to the profile picture.
    bio TEXT,
    website VARCHAR(255), -- User's website URL (optional).
    gender ENUM('Male', 'Female'),
    birth_date DATE,
    account_privacy BOOLEAN DEFAULT TRUE, -- True for public, False for private
    user_id INTEGER UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- follows table (Can be seperated)
CREATE TABLE follows (
    id SERIAL PRIMARY KEY,
    following_user_id INTEGER NOT NULL,
    followed_user_id INTEGER NOT NULL,
	  status ENUM('Pending', 'Approved', 'Rejected'),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (following_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (followed_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- messages table
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    content TEXT,
    seen BOOLEAN DEFAULT FALSE, -- Flag indicating if the message has been seen by the recipient.
    sender_id INTEGER NOT NULL,
    receiver_id INTEGER NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

-- post_types table
CREATE TABLE post_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE -- 'story', 'profile', etc.
);

-- posts table
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    caption TEXT,
    post_type_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_type_id) REFERENCES post_type(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- post_medias table
CREATE TABLE post_medias (
    id SERIAL PRIMARY KEY,
    media_file VARCHAR(255),
    position INTEGER, -- Order in which the media appears in the post
    longitude FLOAT,
    latitude FLOAT,
    post_id INTEGER NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE
);

-- post_media_user_tags table
CREATE TABLE post_media_user_tags (
    id SERIAL PRIMARY KEY,
    x_coordinate INTEGER,
    y_coordinate INTEGER,
    post_media_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (post_media_id) REFERENCES post_media(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- saved_posts table
CREATE TABLE saved_posts (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- comments table
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    comment TEXT,
    like_count INTEGER DEFAULT 0,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment_replied_to_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (comment_replied_to_id) REFERENCES Comment(id) ON DELETE CASCADE
);

-- reactions table
CREATE TABLE reactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    target_id INTEGER NOT NULL,
    reaction_type ENUM('post', 'comment'),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT valid_reaction_target CHECK (reaction_type = 'post' AND target_id IN (SELECT id FROM posts)
                                              OR reaction_type = 'comment' AND target_id IN (SELECT id FROM comments))
);
```
