-- Inserting data into users table
TRUNCATE TABLE users RESTART IDENTITY CASCADE;
INSERT INTO users (username, email, password, created_date)
VALUES ('john_doe', 'john.doe@example.com', 'password123', '2023-01-10 10:00:00'),
       ('jane_smith', 'jane.smith@example.com', 'password123', '2023-01-11 11:00:00'),
       ('alice_jones', 'alice.jones@example.com', 'password123', '2023-01-12 12:00:00'),
       ('bob_brown', 'bob.brown@example.com', 'password123', '2023-01-13 13:00:00'),
       ('charlie_black', 'charlie.black@example.com', 'password123', '2023-01-14 14:00:00'),
       ('david_white', 'david.white@example.com', 'password123', '2023-01-15 15:00:00'),
       ('emma_wilson', 'emma.wilson@example.com', 'password123', '2023-01-16 16:00:00'),
       ('frank_miller', 'frank.miller@example.com', 'password123', '2023-01-17 17:00:00'),
       ('grace_davis', 'grace.davis@example.com', 'password123', '2023-01-18 18:00:00'),
       ('henry_martin', 'henry.martin@example.com', 'password123', '2023-01-19 19:00:00'),
       ('irene_clark', 'irene.clark@example.com', 'password123', '2023-01-20 20:00:00'),
       ('jack_thompson', 'jack.thompson@example.com', 'password123', '2023-01-21 21:00:00'),
       ('karen_lopez', 'karen.lopez@example.com', 'password123', '2023-01-22 22:00:00'),
       ('leo_gonzalez', 'leo.gonzalez@example.com', 'password123', '2023-01-23 23:00:00'),
       ('mia_walker', 'mia.walker@example.com', 'password123', '2023-01-24 08:00:00'),
       ('noah_hall', 'noah.hall@example.com', 'password123', '2023-01-25 09:00:00'),
       ('olivia_allen', 'olivia.allen@example.com', 'password123', '2023-01-26 10:00:00'),
       ('paul_scott', 'paul.scott@example.com', 'password123', '2023-01-27 11:00:00'),
       ('quinn_adams', 'quinn.adams@example.com', 'password123', '2023-01-28 12:00:00'),
       ('rachel_baker', 'rachel.baker@example.com', 'password123', '2023-01-29 13:00:00');

select *
from users;

-- Inserting data into user_details table
TRUNCATE TABLE user_details RESTART IDENTITY CASCADE;
INSERT INTO user_details (first_name, last_name, phone_number, profile_picture, bio, website, gender, birth_date,
                          account_privacy, user_id)
VALUES ('John', 'Doe', '123-456-7890', 'path/to/profile_picture1.jpg', 'Hello, I am John!', 'http://johnswebsite.com',
        'Male', '1990-01-10', TRUE, 1),
       ('Jane', 'Smith', '123-456-7891', 'path/to/profile_picture2.jpg', 'Hello, I am Jane!', 'http://janeswebsite.com',
        'Female', '1991-02-20', TRUE, 2),
       ('Alice', 'Jones', '123-456-7892', 'path/to/profile_picture3.jpg', 'Hello, I am Alice!',
        'http://aliceswebsite.com', 'Female', '1992-03-15', TRUE, 3),
       ('Bob', 'Brown', '123-456-7893', 'path/to/profile_picture4.jpg', 'Hello, I am Bob!', 'http://bobswebsite.com',
        'Male', '1988-04-25', TRUE, 4),
       ('Charlie', 'Black', '123-456-7894', 'path/to/profile_picture5.jpg', 'Hello, I am Charlie!',
        'http://charlieswebsite.com', 'Male', '1989-05-30', TRUE, 5),
       ('David', 'White', '123-456-7895', 'path/to/profile_picture6.jpg', 'Hello, I am David!',
        'http://davidswebsite.com', 'Male', '1990-06-20', TRUE, 6),
       ('Emma', 'Wilson', '123-456-7896', 'path/to/profile_picture7.jpg', 'Hello, I am Emma!',
        'http://emmaswebsite.com', 'Female', '1991-07-15', TRUE, 7),
       ('Frank', 'Miller', '123-456-7897', 'path/to/profile_picture8.jpg', 'Hello, I am Frank!',
        'http://frankswebsite.com', 'Male', '1992-08-10', TRUE, 8),
       ('Grace', 'Davis', '123-456-7898', 'path/to/profile_picture9.jpg', 'Hello, I am Grace!',
        'http://graceswebsite.com', 'Female', '1993-09-05', TRUE, 9),
       ('Henry', 'Martin', '123-456-7899', 'path/to/profile_picture10.jpg', 'Hello, I am Henry!',
        'http://henryswebsite.com', 'Male', '1994-10-25', TRUE, 10),
       ('Irene', 'Clark', '123-456-7800', 'path/to/profile_picture11.jpg', 'Hello, I am Irene!',
        'http://ireneswebsite.com', 'Female', '1995-11-20', TRUE, 11),
       ('Jack', 'Thompson', '123-456-7801', 'path/to/profile_picture12.jpg', 'Hello, I am Jack!',
        'http://jackswebsite.com', 'Male', '1996-12-15', TRUE, 12),
       ('Karen', 'Lopez', '123-456-7802', 'path/to/profile_picture13.jpg', 'Hello, I am Karen!',
        'http://karenswebsite.com', 'Female', '1997-01-10', TRUE, 13),
       ('Leo', 'Gonzalez', '123-456-7803', 'path/to/profile_picture14.jpg', 'Hello, I am Leo!',
        'http://leoswebsite.com', 'Male', '1998-02-05', TRUE, 14),
       ('Mia', 'Walker', '123-456-7804', 'path/to/profile_picture15.jpg', 'Hello, I am Mia!', 'http://miaswebsite.com',
        'Female', '1999-03-01', TRUE, 15),
       ('Noah', 'Hall', '123-456-7805', 'path/to/profile_picture16.jpg', 'Hello, I am Noah!', 'http://noahswebsite.com',
        'Male', '2000-04-25', TRUE, 16),
       ('Olivia', 'Allen', '123-456-7806', 'path/to/profile_picture17.jpg', 'Hello, I am Olivia!',
        'http://oliviaswebsite.com', 'Female', '2001-05-20', TRUE, 17),
       ('Paul', 'Scott', '123-456-7807', 'path/to/profile_picture18.jpg', 'Hello, I am Paul!',
        'http://paulswebsite.com', 'Male', '2002-06-15', TRUE, 18),
       ('Quinn', 'Adams', '123-456-7808', 'path/to/profile_picture19.jpg', 'Hello, I am Quinn!',
        'http://quinnswebsite.com', 'Male', '2003-07-10', TRUE, 19),
       ('Rachel', 'Baker', '123-456-7809', 'path/to/profile_picture20.jpg', 'Hello, I am Rachel!',
        'http://rachelswebsite.com', 'Female', '2004-08-05', TRUE, 20);

select *
from user_details;

-- Inserting data into post_types
TRUNCATE TABLE post_types RESTART IDENTITY CASCADE;
INSERT INTO post_types (name)
VALUES ('story'),
       ('profile');

select *
from post_types;

-- Inserting data into posts
TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
INSERT INTO posts (caption, post_type_id, user_id, created_date)
VALUES ('This is my first story!', 1, 1, '2023-01-10 12:00:00'),
       ('Loving the new profile picture!', 2, 2, '2023-01-15 13:00:00'),
       ('Check out my latest adventure!', 1, 3, '2023-02-20 14:00:00'),
       ('Profile updated for the new year!', 2, 4, '2023-03-25 15:00:00'),
       ('Just another day in paradise.', 1, 5, '2023-04-30 16:00:00'),
       ('New profile pic, who dis?', 2, 6, '2023-05-20 17:00:00'),
       ('Sunset stories are the best.', 1, 7, '2023-06-15 18:00:00'),
       ('Updated my profile, what do you think?', 2, 8, '2023-07-10 19:00:00'),
       ('Throwback story from last summer.', 1, 9, '2023-08-05 20:00:00'),
       ('Profile pic updated, feeling good!', 2, 10, '2023-09-25 21:00:00'),
       ('Daily story update!', 1, 11, '2023-10-20 22:00:00'),
       ('New look, new profile.', 2, 12, '2023-11-15 23:00:00'),
       ('Stories from my travels.', 1, 13, '2023-12-10 08:00:00'),
       ('Profile pic refresh for the holidays.', 2, 14, '2023-12-25 09:00:00'),
       ('Sharing my weekend story.', 1, 15, '2024-01-10 10:00:00'),
       ('Updated profile with new pics.', 2, 16, '2024-01-20 11:00:00'),
       ('Behind the scenes story!', 1, 17, '2024-02-05 12:00:00'),
       ('Profile updated for a fresh start.', 2, 18, '2024-02-25 13:00:00'),
       ('Daily story, here it goes.', 1, 19, '2024-03-10 14:00:00'),
       ('New profile pic alert!', 2, 20, '2024-03-25 15:00:00'),
       ('Just sharing a quick story.', 1, 1, '2024-04-10 16:00:00'),
       ('Profile update with new memories.', 2, 2, '2024-04-20 17:00:00'),
       ('Story time from the weekend.', 1, 3, '2024-05-10 18:00:00'),
       ('Fresh profile pic for the month!', 2, 4, '2024-05-20 19:00:00'),
       ('Daily update story.', 1, 5, '2024-06-10 20:00:00'),
       ('New profile, new me.', 2, 6, '2024-06-25 21:00:00'),
       ('Sharing today''s story.', 1, 7, '2024-07-10 22:00:00'),
       ('Profile pic changed again!', 2, 8, '2024-07-20 23:00:00'),
       ('Summer story updates.', 1, 9, '2024-08-05 08:00:00'),
       ('Updated my profile for summer.', 2, 10, '2024-08-25 09:00:00');

select *
from posts;

-- Insert data into post_medias table ensuring each post has at least one media entry and correct positioning
TRUNCATE TABLE post_medias RESTART IDENTITY CASCADE;
INSERT INTO post_medias (media_file, position, longitude, latitude, post_id)
VALUES
-- Post 1
('https://example.com/media/1-1.jpg', 1, 40.7128, -74.0060, 1),
('https://example.com/media/1-2.jpg', 2, 40.7128, -74.0060, 1),

-- Post 2
('https://example.com/media/2-1.jpg', 1, 34.0522, -118.2437, 2),

-- Post 3
('https://example.com/media/3-1.jpg', 1, 51.5074, -0.1278, 3),
('https://example.com/media/3-2.jpg', 2, 51.5074, -0.1278, 3),
('https://example.com/media/3-3.jpg', 3, 51.5074, -0.1278, 3),

-- Post 4
('https://example.com/media/4-1.jpg', 1, 48.8566, 2.3522, 4),

-- Post 5
('https://example.com/media/5-1.jpg', 1, 35.6895, 139.6917, 5),

-- Post 6
('https://example.com/media/6-1.jpg', 1, -33.8688, 151.2093, 6),

-- Post 7
('https://example.com/media/7-1.jpg', 1, 40.7128, -74.0060, 7),
('https://example.com/media/7-2.jpg', 2, 40.7128, -74.0060, 7),

-- Post 8
('https://example.com/media/8-1.jpg', 1, 34.0522, -118.2437, 8),
('https://example.com/media/8-2.jpg', 2, 34.0522, -118.2437, 8),

-- Post 9
('https://example.com/media/9-1.jpg', 1, 51.5074, -0.1278, 9),

-- Post 10
('https://example.com/media/10-1.jpg', 1, 48.8566, 2.3522, 10),
('https://example.com/media/10-2.jpg', 2, 48.8566, 2.3522, 10),

-- Post 11
('https://example.com/media/11-1.jpg', 1, 35.6895, 139.6917, 11),

-- Post 12
('https://example.com/media/12-1.jpg', 1, -33.8688, 151.2093, 12),
('https://example.com/media/12-2.jpg', 2, -33.8688, 151.2093, 12),

-- Post 13
('https://example.com/media/13-1.jpg', 1, 40.7128, -74.0060, 13),

-- Post 14
('https://example.com/media/14-1.jpg', 1, 34.0522, -118.2437, 14),
('https://example.com/media/14-2.jpg', 2, 34.0522, -118.2437, 14),

-- Post 15
('https://example.com/media/15-1.jpg', 1, 51.5074, -0.1278, 15),
('https://example.com/media/15-2.jpg', 2, 51.5074, -0.1278, 15),

-- Post 16
('https://example.com/media/16-1.jpg', 1, 48.8566, 2.3522, 16),

-- Post 17
('https://example.com/media/17-1.jpg', 1, 35.6895, 139.6917, 17),
('https://example.com/media/17-2.jpg', 2, 35.6895, 139.6917, 17),

-- Post 18
('https://example.com/media/18-1.jpg', 1, -33.8688, 151.2093, 18),

-- Post 19
('https://example.com/media/19-1.jpg', 1, 40.7128, -74.0060, 19),
('https://example.com/media/19-2.jpg', 2, 40.7128, -74.0060, 19),

-- Post 20
('https://example.com/media/20-1.jpg', 1, 34.0522, -118.2437, 20),

-- Post 21
('https://example.com/media/21-1.jpg', 1, 51.5074, -0.1278, 21),

-- Post 22
('https://example.com/media/22-1.jpg', 1, 48.8566, 2.3522, 22),
('https://example.com/media/22-2.jpg', 2, 48.8566, 2.3522, 22),

-- Post 23
('https://example.com/media/23-1.jpg', 1, 35.6895, 139.6917, 23),

-- Post 24
('https://example.com/media/24-1.jpg', 1, -33.8688, 151.2093, 24),
('https://example.com/media/24-2.jpg', 2, -33.8688, 151.2093, 24),

-- Post 25
('https://example.com/media/25-1.jpg', 1, 40.7128, -74.0060, 25),

-- Post 26
('https://example.com/media/26-1.jpg', 1, 34.0522, -118.2437, 26),
('https://example.com/media/26-2.jpg', 2, 34.0522, -118.2437, 26),

-- Post 27
('https://example.com/media/27-1.jpg', 1, 51.5074, -0.1278, 27),

-- Post 28
('https://example.com/media/28-1.jpg', 1, 48.8566, 2.3522, 28),
('https://example.com/media/28-2.jpg', 2, 48.8566, 2.3522, 28),

-- Post 29
('https://example.com/media/29-1.jpg', 1, 35.6895, 139.6917, 29),

-- Post 30
('https://example.com/media/30-1.jpg', 1, -33.8688, 151.2093, 30),
('https://example.com/media/30-2.jpg', 2, -33.8688, 151.2093, 30);

select *
from post_medias;

-- Insert follow relationships considering user account privacy
TRUNCATE TABLE follows RESTART IDENTITY CASCADE;
INSERT INTO follows (following_user_id, followed_user_id, status)
SELECT f1.id   AS following_user_id,
       f2.id   AS followed_user_id,
       CASE
           WHEN ud.account_privacy = TRUE THEN 'Approved'::follow_status_enum -- Public account
           ELSE 'Pending'::follow_status_enum -- Private account
           END AS status
FROM users f1
         JOIN
     users f2 ON f1.id <> f2.id -- Ensure no self-following
         JOIN
     user_details ud ON f2.id = ud.user_id -- Join to check account privacy
ORDER BY RANDOM() -- Randomize follow relationships
LIMIT 40; -- Limit to 40 follow relationships

select *
from follows;

-- Insert random data into post_media_user_tags table
TRUNCATE TABLE post_media_user_tags RESTART IDENTITY CASCADE;
INSERT INTO post_media_user_tags (x_coordinate, y_coordinate, post_media_id, user_id)
SELECT floor(random() * 1080) + 1, -- 1080px
       floor(random() * 1080) + 1, -- 1080px
       floor(random() * 46) + 1,
       floor(random() * 20) + 1
FROM generate_series(1, 50) AS id;

select *
from post_media_user_tags;

-- Insert sample messages into the messages table
TRUNCATE TABLE messages RESTART IDENTITY CASCADE;
INSERT INTO messages (content, seen, sender_id, receiver_id, created_date)
VALUES ('Hey Jane, how are you?', FALSE, 1, 2, '2024-01-10 10:00:00'),
       ('Hi John, I am good. How about you?', FALSE, 2, 1, '2024-01-10 10:05:00'),
       ('Alice, did you see the latest update?', TRUE, 3, 4, '2024-01-11 12:00:00'),
       ('Yes, Bob, it looks great!', TRUE, 4, 3, '2024-01-11 12:10:00'),
       ('Charlie, are we still on for the meeting tomorrow?', FALSE, 5, 6, '2024-01-12 14:00:00'),
       ('David, yes we are! Looking forward to it.', FALSE, 6, 5, '2024-01-12 14:15:00'),
       ('Emma, can you review my latest code?', FALSE, 7, 8, '2024-01-13 16:00:00'),
       ('Sure, Frank. I will take a look this evening.', FALSE, 8, 7, '2024-01-13 16:30:00'),
       ('Grace, lets catch up over coffee.', TRUE, 9, 10, '2024-01-14 18:00:00'),
       ('Henry, sounds good! When are you free?', TRUE, 10, 9, '2024-01-14 18:20:00'),
       ('Irene, can you send me the project files?', FALSE, 11, 12, '2024-01-15 20:00:00'),
       ('Jack, sure thing. Sending them now.', TRUE, 12, 11, '2024-01-15 20:10:00'),
       ('Karen, are you joining the team dinner?', FALSE, 13, 14, '2024-01-16 22:00:00'),
       ('Leo, yes! I will be there.', FALSE, 14, 13, '2024-01-16 22:30:00'),
       ('Mia, do you have the latest report?', FALSE, 15, 16, '2024-01-17 08:00:00'),
       ('Noah, I will send it to you by noon.', FALSE, 16, 15, '2024-01-17 08:20:00'),
       ('Olivia, can we discuss the new project?', TRUE, 17, 18, '2024-01-18 09:00:00'),
       ('Paul, lets meet at 2 PM today.', TRUE, 18, 17, '2024-01-18 09:30:00'),
       ('Quinn, are the designs ready?', FALSE, 19, 20, '2024-01-19 10:00:00'),
       ('Rachel, yes, I will share them shortly.', FALSE, 20, 19, '2024-01-19 10:30:00');

select *
from messages;

-- Inserting data into saved_posts table:
TRUNCATE TABLE saved_posts RESTART IDENTITY CASCADE;
INSERT INTO saved_posts (user_id, post_id, created_date)
VALUES (1, 3, '2023-01-12 10:30:00'),
       (1, 5, '2023-01-13 14:45:00'),
       (2, 1, '2023-01-14 09:00:00'),
       (2, 4, '2023-01-14 11:15:00'),
       (3, 2, '2023-01-15 16:00:00'),
       (3, 7, '2023-01-16 08:30:00'),
       (4, 1, '2023-01-17 10:00:00'),
       (4, 6, '2023-01-18 12:45:00'),
       (5, 8, '2023-01-19 09:30:00'),
       (5, 9, '2023-01-19 15:00:00'),
       (6, 3, '2023-01-20 10:30:00'),
       (6, 4, '2023-01-21 11:30:00'),
       (7, 2, '2023-01-22 09:45:00'),
       (7, 5, '2023-01-23 14:15:00'),
       (8, 6, '2023-01-24 16:30:00'),
       (8, 7, '2023-01-25 12:00:00'),
       (9, 1, '2023-01-26 10:00:00'),
       (9, 8, '2023-01-27 15:30:00'),
       (10, 9, '2023-01-28 09:00:00'),
       (10, 3, '2023-01-29 11:00:00'),
       (11, 5, '2023-01-30 13:30:00'),
       (11, 7, '2023-01-31 14:45:00'),
       (12, 2, '2023-02-01 10:15:00'),
       (12, 6, '2023-02-02 12:30:00'),
       (13, 4, '2023-02-03 11:45:00'),
       (13, 8, '2023-02-04 14:00:00'),
       (14, 1, '2023-02-05 09:30:00'),
       (14, 3, '2023-02-06 10:45:00'),
       (15, 2, '2023-02-07 11:30:00'),
       (15, 5, '2023-02-08 12:15:00'),
       (16, 6, '2023-02-09 13:00:00'),
       (16, 7, '2023-02-10 14:30:00'),
       (17, 9, '2023-02-11 15:45:00'),
       (17, 4, '2023-02-12 16:00:00'),
       (18, 8, '2023-02-13 09:00:00'),
       (18, 3, '2023-02-14 10:30:00'),
       (19, 1, '2023-02-15 11:00:00'),
       (19, 5, '2023-02-16 12:45:00'),
       (20, 7, '2023-02-17 14:00:00'),
       (20, 2, '2023-02-18 15:30:00');

select *
from saved_posts;

-- Inserting data into comments table:
TRUNCATE TABLE comments RESTART IDENTITY CASCADE;
INSERT INTO comments (comment, post_id, user_id, comment_replied_to_id)
VALUES
-- Comments on John's profile post
('Nice profile picture, John!', 1, 2, NULL),       -- Jane commenting on John's post
('Thank you, Jane!', 1, 1, 1),                     -- John replying to Jane's comment
('Great to see your updates, John.', 1, 3, NULL),  -- Alice commenting on John's post
('Thanks, Alice!', 1, 1, 3),                       -- John replying to Alice's comment
('Looking good, John!', 1, 4, NULL),               -- Michael commenting on John's post
('Appreciate it, Michael.', 1, 1, 5),              -- John replying to Michael's comment

-- Comments on Jane's profile post
('Amazing post, Jane!', 2, 1, NULL),               -- John commenting on Jane's post
('Thanks, John!', 2, 2, 7),                        -- Jane replying to John's comment
('Lovely profile, Jane!', 2, 3, NULL),             -- Alice commenting on Jane's post
('Thank you, Alice!', 2, 2, 9),                    -- Jane replying to Alice's comment
('So happy to see your posts, Jane!', 2, 5, NULL), -- Linda commenting on Jane's post
('Glad to hear that, Linda.', 2, 2, 11),           -- Jane replying to Linda's comment

-- Comments on Alice's profile post
('Great content, Alice!', 3, 1, NULL),             -- John commenting on Alice's post
('Thank you, John!', 3, 3, 13),                    -- Alice replying to John's comment
('Nice updates, Alice.', 3, 2, NULL),              -- Jane commenting on Alice's post
('Thanks, Jane!', 3, 3, 15),                       -- Alice replying to Jane's comment
('Your profile looks great, Alice!', 3, 4, NULL),  -- Michael commenting on Alice's post
('Appreciate it, Michael.', 3, 3, 17),             -- Alice replying to Michael's comment

-- Comments on Michael's profile post
('Cool profile, Michael!', 4, 1, NULL),            -- John commenting on Michael's post
('Thanks, John!', 4, 4, 19),                       -- Michael replying to John's comment
('Nice posts, Michael.', 4, 2, NULL),              -- Jane commenting on Michael's post
('Thank you, Jane!', 4, 4, 21),                    -- Michael replying to Jane's comment
('Great profile updates, Michael!', 4, 3, NULL),   -- Alice commenting on Michael's post
('Thanks, Alice!', 4, 4, 23),                      -- Michael replying to Alice's comment

-- Comments on Linda's profile post
('Nice profile, Linda!', 5, 1, NULL),              -- John commenting on Linda's post
('Thank you, John!', 5, 5, 25),                    -- Linda replying to John's comment
('Lovely posts, Linda.', 5, 2, NULL),              -- Jane commenting on Linda's post
('Thanks, Jane!', 5, 5, 27),                       -- Linda replying to Jane's comment
('Your updates are great, Linda!', 5, 3, NULL),    -- Alice commenting on Linda's post
('Appreciate it, Alice.', 5, 5, 29); -- Linda replying to Alice's comment

select *
from comments;

-- Generate sample data for the content_activity table
TRUNCATE TABLE content_activity RESTART IDENTITY CASCADE;
INSERT INTO content_activity (parent_id, count)
SELECT id, 0
FROM posts
UNION
SELECT id, 0
FROM comments;

select *
from content_activity;

-- Inserting more data into likes table:
INSERT INTO likes (user_id, entity_id, entity_type)
VALUES (2, 1, 'Comment'),  -- Jane likes John's profile picture comment
       (1, 2, 'Comment'),  -- John likes Jane's thank you comment
       (4, 1, 'Comment'),  -- Alice likes John's updates comment
       (1, 3, 'Comment'),  -- John likes Alice's thank you comment
       (5, 1, 'Comment'),  -- Michael likes John's profile comment
       (1, 5, 'Comment'),  -- John likes Michael's thank you comment
       (1, 7, 'Comment'),  -- John likes Jane's amazing post comment
       (2, 9, 'Comment'),  -- Jane likes her own lovely profile comment
       (2, 11, 'Comment'), -- Jane likes her own happy to see posts comment
       (5, 13, 'Comment'), -- Michael likes Alice's great content comment
       (3, 15, 'Comment'), -- Michael likes Alice's nice updates comment
       (1, 17, 'Comment'), -- John likes Alice's profile looks great comment
       (4, 19, 'Comment'), -- Michael likes his own cool profile comment
       (2, 21, 'Comment'), -- Jane likes Michael's nice posts comment
       (1, 23, 'Comment'), -- John likes Michael's great profile updates comment
       (5, 25, 'Comment'), -- Michael likes Linda's nice profile comment
       (1, 27, 'Comment'), -- John likes Linda's lovely posts comment
       (2, 29, 'Comment'), -- Jane likes Linda's updates are great comment
       (3, 1, 'Post'),     -- Michael likes John's first story
       (1, 2, 'Post'),     -- John likes Jane's new profile picture post
       (4, 1, 'Post'),     -- Alice likes John's latest adventure post
       (2, 2, 'Post'),     -- Jane likes her own profile updated post
       (1, 5, 'Post'),     -- John likes his own paradise post
       (5, 7, 'Post'),     -- Michael likes Jane's sunset stories post
       (1, 9, 'Post'),     -- John likes his own throwback story post
       (2, 11, 'Post'),    -- Jane likes her own daily story update post
       (4, 13, 'Post'),    -- Alice likes her own stories from travels post
       (3, 15, 'Post'),    -- Michael likes Alice's weekend story post
       (1, 17, 'Post'),    -- John likes his own behind the scenes story post
       (2, 19, 'Post'),    -- Jane likes her own daily story post
       (5, 21, 'Post'),    -- Michael likes Jane's quick story post
       (1, 23, 'Post'),    -- John likes his own story time from the weekend post
       (4, 25, 'Post'); -- Alice likes Linda's daily update story post

select *
from likes;



