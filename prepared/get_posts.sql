-- $1 user_id

-- PREPARE get_posts (INT4) AS
SELECT post_id, p_text AS post_text, time, poster_id, u.user_name AS poster_name, p.group_id as group_id 
FROM  "User" AS u INNER JOIN "Post" AS p 
ON    u.user_id = p.poster_id
WHERE p.group_id IN (SELECT m.group_id
                      FROM "MemberOf" AS m
                      WHERE member_id = $1::INT4);

-- EXECUTE get_posts('Sadat999');
