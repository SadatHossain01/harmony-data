CREATE OR REPLACE FUNCTION add_member(
    adder_id INT4,
    added_id INT4,
    gid INT4) RETURNS TEXT AS
$$
DECLARE
    ret    JSON;
BEGIN
    IF NOT check_user_is_admin(adder_id, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'adder not a group_admin');
    ELSE
        INSERT INTO "MemberOf" (group_id, member_id, access) VALUES (gid, added_id, 'member');
        ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
