-- $1 user_id
-- PREPARE get_groups(INT4) AS
SELECT * FROM "Group"
WHERE group_id IN (SELECT m.group_id FROM "MemberOf" AS m
                    WHERE m.member_id = $1::INT4);
