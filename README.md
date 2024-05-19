# Social Media Platform Database

This database schema is designed to support a social media platform resembling Instagram. It includes tables for users, user details, follow relationships, messages, posts, comments, saved posts, and likes.

Link to db diagram:
https://drawsql.app/teams/dias-3/diagrams/social-media

![alt text](diagram.png)

### Connecting to Our PostgreSQL Database

- Database endpoint: `social-media-db.c7oegqky2sza.eu-north-1.rds.amazonaws.com`
- Port: `5432`
- Username: `postgres`
- Password: `Eb00ktash`

### Steps for Database Setup:

1. I have created types, tables, and trigger functions in `create_tables.sql`.
2. I have inserted data into each table to simulate real-life social media interactions using `inserting_real_data.sql`.
3. I have written some useful testing queries to assess the system's functionality. (`testing_queries.sql`)

#### Connection Instructions

1. **Using a PostgreSQL Client:**

   - Download and install a PostgreSQL client such as pgAdmin, DBeaver, DataGrip or psql.
   - Open the client and create a new connection.
   - Enter the provided endpoint, port, username, and password when prompted.
   - Connect to the database.

2. **Using Command Line (psql):**
   - Open a terminal or command prompt.
   - Use the following command to connect:
     ```
     psql -h social-media-db.c7oegqky2sza.eu-north-1.rds.amazonaws.com -p 5432 -U postgres -W
     ```
   - Enter the password when prompted.

## Tables Description

### 1. users

Stores user account information including username, email, and password.

### 2. user_details

Stores additional user profile information such as first name, last name, and profile picture.

### 3. follows

Manages user follow relationships with fields like following_user_id, followed_user_id, and status.

### 4. messages

Stores messages between users with sender_id, receiver_id, content, etc.

### 5. post_types

Defines types of posts like 'story', 'profile', etc.

### 6. posts

Stores post information including caption, post_type_id, user_id, etc.

### 7. post_medias

Stores media files related to posts with fields like media_file, position, longitude, latitude, etc.

### 8. post_media_user_tags

Stores user tags on media files with x_coordinate, y_coordinate, post_media_id, user_id, etc.

### 9. saved_posts

Manages saved posts by users with post_id, user_id, created_date, etc.

### 10. comments

Stores comments on posts with comment text, like_count, post_id, user_id, etc.

### 11. content_activity

Manages the number of likes that a post or comment has.

### 12. likes

Stores likes on posts and comments with fields like user_id, entity_id, entity_type, and created_date.

## Relationships Between Tables

1. **Users to User_details:**

   - Each user has only one set of user details (first name, last name, etc.), creating a one-to-one relationship

2. **Users to Followers/Following (Follows Table):**

   - Many-to-many relationship where a user can follow multiple users and be followed by multiple users.

3. **Users to Messages (Sender and Receiver):**

   - One-to-many relationship where a user can send multiple messages, but each message has one sender and one receiver.

4. **Users to Posts:**

   - One-to-many relationship where a user can create multiple posts, but each post has one user as the creator.

5. **Users to Saved_posts:**

   - One-to-many relationship where each user can have multiple saved posts (favorites or collections), but each saved post belongs to only one user.

6. **Posts to Post Media:**

   - One-to-many relationship where a post can have multiple media files associated with it.

7. **Posts to Post Media User Tags (Post_Media_User_Tag Table):**

   - Many-to-many relationship where multiple users can be tagged in multiple posts, and one post can have multiple users tagged in it.

8. **Users to Comments:**

   - One-to-many relationship where a user can comment on multiple posts, but each comment has one user as the author.

9. **Posts to Saved Posts (indirectly):**

   - Many-to-one. Each post can have multiple instances of being saved by different users, but each instance of saved post belongs to only one post. This relationship indirectly contributes to the many-to-many relationship between users and posts facilitated by the saved_posts junction table.

10. **Posts to Comments**

    - One-to-many relationship where a post can have multiple comments, but each comment belongs to only one post.

11. **Posts/Comments to Content Activity:**

    - One-to-one relationship where a post or a comment is associated with its like count.

12. **Posts/Comments to Likes:**

    - One-to-many relationship where each post or comment can have multiple likes, but each like belongs to only one post or comment.
