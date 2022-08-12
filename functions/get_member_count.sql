CREATE OR REPLACE FUNCTION get_member_count(g_id INTEGER) RETURNS INTEGER AS
$$
DECLARE
    count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM "MemberOf"
    WHERE "MemberOf".group_id = g_id;
    RETURN count;
END ;
$$
    LANGUAGE plpgsql;

-- SELECT group_name, get_member_count(group_id)
-- FROM "Group";