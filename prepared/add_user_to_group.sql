-- PREPARE add_user_to_group (VARCHAR, VARCHAR) AS
INSERT INTO "MemberOf" (member_id, group_id)
VALUES ((SELECT user_id
            FROM "User"
            WHERE "User".user_name = $1::VARCHAR
            LIMIT 1),
        (SELECT group_id
            FROM "Group"
            WHERE "Group".group_name = $2::VARCHAR
            LIMIT 1));

-- EXECUTE add_user_to_group('Sadat999', 'CSE19');