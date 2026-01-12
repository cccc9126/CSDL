-- =========================================
-- BÀI: ĐĂNG BÀI + GỬI THÔNG BÁO CHO BẠN BÈ
-- =========================================

-- 1) Sử dụng database
USE social_network_pro;

-- 2) Tạo stored procedure NotifyFriendsOnNewPost
DELIMITER $$

CREATE PROCEDURE NotifyFriendsOnNewPost(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE new_post_id INT;
    DECLARE poster_name VARCHAR(255);

    -- Lấy tên người đăng
    SELECT full_name
    INTO poster_name
    FROM users
    WHERE user_id = p_user_id;

    -- Thêm bài viết mới
    INSERT INTO posts(user_id, content, created_at)
    VALUES (p_user_id, p_content, NOW());

    -- Lấy post_id vừa tạo
    SET new_post_id = LAST_INSERT_ID();

    -- Gửi thông báo cho bạn bè (2 chiều, đã accepted)
    INSERT INTO notifications(user_id, type, content, created_at)
    SELECT 
        CASE 
            WHEN f.user_id = p_user_id THEN f.friend_id
            ELSE f.user_id
        END AS notify_user_id,
        'new_post',
        CONCAT(poster_name, ' đã đăng một bài viết mới'),
        NOW()
    FROM friends f
    WHERE f.status = 'accepted'
      AND (f.user_id = p_user_id OR f.friend_id = p_user_id)
      AND (
            CASE 
                WHEN f.user_id = p_user_id THEN f.friend_id
                ELSE f.user_id
            END
          ) <> p_user_id;
END $$

DELIMITER ;

-- 3) Gọi procedure để thêm bài viết mới
CALL NotifyFriendsOnNewPost(1, 'Hôm nay trời đẹp quá anh em ơi');

-- 4) Kiểm tra các thông báo vừa được tạo
SELECT *
FROM notifications
ORDER BY created_at DESC;

-- 5) Xóa stored procedure
DROP PROCEDURE NotifyFriendsOnNewPost;
