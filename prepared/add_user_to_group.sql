-- $1 user_id
-- $2 group_id

-- PREPARE add_user_to_group (INT4, INT4) AS
INSERT INTO "MemberOf" (member_id, group_id)
VALUES ($1::INT4, $2::INT4);

-- EXECUTE add_user_to_group('Sadat999', 'CSE19');
