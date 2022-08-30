CREATE OR REPLACE FUNCTION remove_member(
    remover_id INT4,
    removed_id INT4,
    gid INT4) RETURNS TEXT AS
$$
DECLARE
    ret JSON;
BEGIN
    IF NOT check_user_is_admin(adder_id, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'remover not a group_admin');
    ELSE
        DELETE FROM "MemberOf" WHERE member_id = removed_id;
        ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
