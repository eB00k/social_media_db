# Social Media Platform Database Schema

### Tables

- Users: Store user information such as username, email, password, etc.
- User_details: Store additional user details like first name, last name, profile picture, bio, etc. (Can be a one-to-one relationship with Users table).
- Follows: Manage user follow relationships with fields like following_user_id, followed_user_id, and status.
- Messages: Store messages between users with sender_id, receiver_id, content, etc.
- Post_type: Define types of posts like 'story', 'profile', etc.
- Post: Store post information including caption, post_type_id, user_id, etc.
- Post_media: Store media files related to posts with fields like media_file, position, post_id, etc.
- Post_media_user_tag: Store user tags on media files with x_coordinate, y_coordinate, post_media_id, user_id, etc.
- Saved_post: Manage saved posts by users with post_id, user_id, created_date, etc.
- Comment: Store comments on posts with comment text, like_count, post_id, user_id, etc.
- Reaction: Manage user reactions (e.g., likes) on posts or comments with user_id, post_id, etc.

#

### Relationships Between Tables

1. **Users to User_details:**

   - Each user has only one set of user details (first name, last name, etc.), creating a one-to-one relationship

2. **Users to Followers/Following (Follows Table):**

   - Many-to-many relationship where a user can follow multiple users and be followed by multiple users.

3. **Users to Messages (Sender and Receiver):**

   - One-to-many relationship where a user can send multiple messages, but each message has one sender and one receiver.

4. **Users to Posts:**

   - One-to-many relationship where a user can create multiple posts, but each post has one user as the creator.

5. **Users to Saved_posts:**

   - Many-to-many relationship where a user can save multiple posts, and a post can be saved by multiple users.

6. **Posts to Post Media:**

   - One-to-many relationship where a post can have multiple media files associated with it.

7. **Posts to Tags (Post_Media_User_Tag Table):**

   - Explanation: Many-to-many relationshipm, where many users can be tagged in multiple posts, and one post can have multiple users tagged in it.
   - Intermediate Table: `post_media_user_tag`, linking `user_id` and `post_media_id` between the `users` and `post_media` tables.

8. **Users to Comments:**

   - One-to-many relationship where a user can comment on multiple posts, but each comment has one user as the author.

9. **Posts to Comments:**

   - One-to-many relationship where a post can have multiple comments

10. **Posts to Saved Posts:**

- Explanation: Each post can be saved by multiple users, and one user can save multiple posts, creating a many-to-many relationship. creating a one-to-one relationship.

11. **Users to Reactions (Likes):**

- One-to-many relationship where a user can give reactions (likes) to multiple posts or comments, but each reaction is associated with only one user.

12. **Posts/Comments to Reactions:**

- Explanation: One-to-many relationship where a post or a comment can receive multiple reactions (likes) from users, but each reaction is associated with only one post or comment.
