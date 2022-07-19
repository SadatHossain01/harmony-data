-- space between add_user and '(' is mandatory
-- in the subqueries inside a PREPARE statement, mention the table reference
PREPARE add_user (VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) AS
    INSERT INTO "User" (user_name, password, first_name, middle_name, last_name)
    VALUES ($1, $2, $3, $4, $5);

EXECUTE add_user('Sadat999', 'password', 'Mohammad', 'Sadat', 'Hossain');

PREPARE create_group (VARCHAR) AS
    INSERT INTO "Group" (group_name, intro)
    VALUES ($1, $2);

EXECUTE create_group('CSE19', 'Welcome to CSELand');

PREPARE delete_group (VARCHAR) AS
    DELETE
    FROM "Group"
    WHERE group_name = $1;

EXECUTE delete_group('CSE19');

-- LIMIT limits the number of rows returned

PREPARE join_group (VARCHAR, VARCHAR) AS
    INSERT INTO "MemberOf" (member_id, group_id)
    VALUES ((SELECT user_id
             FROM "User"
             WHERE "User".user_name = $1
             LIMIT 1),
            (SELECT group_id
             FROM "Group"
             WHERE "Group".group_name = $2
             LIMIT 1));

EXECUTE join_group('Sadat999', 'CSE19');

-- Delete a PREPARED statement
DEALLOCATE join_group;

PREPARE make_post (TEXT, VARCHAR, VARCHAR) AS
    INSERT INTO "Post" (p_text, poster_id, group_id)
    VALUES ($1, (SELECT user_id
                 FROM "User"
                 WHERE "User".user_name = $2),
            (SELECT group_id
             FROM "Group"
             WHERE "Group".group_name = $3));

EXECUTE make_post('Hi? How are you all?', 'Sadat999', 'CSE19');

PREPARE visible_post (VARCHAR) AS
    SELECT *
    FROM "Post"
    WHERE group_id IN (SELECT group_id
                       FROM "MemberOf"
                       WHERE member_id IN (SELECT user_id
                                           FROM "User"
                                           WHERE user_name = $1));

EXECUTE visible_post('Sadat999');

DEALLOCATE visible_post;

PREPARE my_groups (VARCHAR) AS
    SELECT *
    FROM "Group"
    WHERE group_id IN (SELECT group_id
                       FROM "MemberOf"
                       WHERE member_id IN (SELECT user_id
                                           FROM "User"
                                           WHERE user_name = $1));

EXECUTE my_groups('Sadat999');