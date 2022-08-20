-- remove all members
-- remove all subjects of that group
-- remove all posts of that group
-- remove all polls of that group

CREATE OR REPLACE FUNCTION delete_group() RETURNS TRIGGER AS
$$
DECLARE
    g_id INTEGER;
BEGIN
    RAISE NOTICE 'deleted group id: %', OLD.group_id;
    g_id := OLD.group_id;
    DELETE FROM "Subject" WHERE parent_group_id = g_id;
    DELETE FROM "MemberOf" WHERE group_id = g_id;
    DELETE FROM "Post" WHERE group_id = g_id;
    DELETE FROM "Poll" WHERE group_id = g_id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
