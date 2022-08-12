-- $1 user_id
-- $2 group_id

-- PREPARE add_user_to_group (INT4, INT4) AS
INSERT INTO "MemberOf" (member_id, group_id)
VALUES ($1::INT4, $2::INT4);

-- PREPARE add_user_to_group_by_name(VARCHAR, VARCHAR) AS
--     INSERT INTO "MemberOf" (member_id, group_id)
--     VALUES ((SELECT user_id FROM "User" WHERE user_name = $1::VARCHAR),
--             (SELECT group_id FROM "Group" WHERE group_name = $2::VARCHAR));
-- EXECUTE add_user_to_group_by_name('risenfromashes', 'EBG');

