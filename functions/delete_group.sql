CREATE OR REPLACE FUNCTION delete_group(
    uid INT,
    gid INT
) RETURNS TEXT AS
$$
DECLARE
    ret JSON;
BEGIN
    IF NOT check_user_is_admin(uid, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'User not group admin');
    ELSE
        DELETE FROM "Group" WHERE group_id = gid;
        ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
