-- PREPARE add_post (TEXT, VARCHAR, VARCHAR) AS
INSERT INTO "Post" (p_text, poster_id, group_id)
VALUES ($1::TEXT, (SELECT user_id
                FROM "User"
                WHERE "User".user_name = $2::VARCHAR),
        (SELECT group_id
            FROM "Group"
            WHERE "Group".group_name = $3::VARCHAR));

-- EXECUTE add_post('Hi? How are you all?', 'Sadat999', 'CSE19');