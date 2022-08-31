CREATE OR REPLACE FUNCTION remove_subject(
    remover_id INT4,
    sid INT4,
    gid INT4) RETURNS TEXT AS
$$
DECLARE
    ret JSON;
BEGIN
    IF NOT check_user_is_admin(remover_id, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'remover not a group_admin');
    ELSE
        DELETE FROM "Subject" WHERE subject_id = sid AND parent_group_id = gid AND subject_name != 'General';
        ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
