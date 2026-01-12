DROP DATABASE IF EXISTS SocialLab;
CREATE DATABASE SocialLab;
USE SocialLab;

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    author VARCHAR(100),
    likes_count INT DEFAULT 0
);

DELIMITER $$

CREATE PROCEDURE sp_CreatePost(
    IN p_content TEXT,
    IN p_author VARCHAR(100),
    OUT p_post_id INT
)
BEGIN
    INSERT INTO posts(content, author)
    VALUES (p_content, p_author);
    SET p_post_id = LAST_INSERT_ID();
END$$

CREATE PROCEDURE sp_SearchPost(
    IN p_keyword VARCHAR(100)
)
BEGIN
    SELECT * FROM posts
    WHERE content LIKE CONCAT('%', p_keyword, '%');
END$$

CREATE PROCEDURE sp_IncreaseLike(
    IN p_post_id INT,
    INOUT p_like INT
)
BEGIN
    UPDATE posts
    SET likes_count = likes_count + 1
    WHERE post_id = p_post_id;

    SELECT likes_count INTO p_like
    FROM posts
    WHERE post_id = p_post_id;
END$$

CREATE PROCEDURE sp_DeletePost(
    IN p_post_id INT
)
BEGIN
    DELETE FROM posts WHERE post_id = p_post_id;
END$$

DELIMITER ;

SET @id1 = 0;
SET @id2 = 0;

CALL sp_CreatePost('hello world', 'Huy', @id1);
CALL sp_CreatePost('hello mysql stored procedure', 'Huy', @id2);

CALL sp_SearchPost('hello');

SET @like = 0;
CALL sp_IncreaseLike(@id1, @like);
SELECT @like;

CALL sp_DeletePost(@id2);

DROP PROCEDURE sp_CreatePost;
DROP PROCEDURE sp_SearchPost;
DROP PROCEDURE sp_IncreaseLike;
DROP PROCEDURE sp_DeletePost;
