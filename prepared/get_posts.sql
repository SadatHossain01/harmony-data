-- PREPARE get_posts (VARCHAR) AS
SELECT *
FROM "Post"
WHERE group_id IN (SELECT group_id
                    FROM "MemberOf"
                    WHERE member_id IN (SELECT user_id
                                        FROM "User"
                                        WHERE user_name = $1::VARCHAR));

-- EXECUTE get_posts('Sadat999');