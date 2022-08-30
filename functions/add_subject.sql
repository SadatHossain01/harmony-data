CREATE OR REPLACE FUNCTION add_subject(
    user_id INT4,
    gid INT4,
    sname VARCHAR) RETURNS TEXT AS
$$
DECLARE
    ret    JSON;
    sub_id INT4;
BEGIN
    IF NOT check_user_is_admin(user_id, gid) THEN
        ret := JSON_BUILD_OBJECT('subject_id', '-1', 'reason', 'User is not an admin.');
    ELSE
        INSERT INTO "Subject" (subject_name, parent_group_id) VALUES (sname, gid) RETURNING subject_id INTO sub_id;
        ret := JSON_BUILD_OBJECT('subject_id', sub_id::TEXT);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
