CREATE OR REPLACE FUNCTION update_member(
    uid INT4,
    mid INT4,
    gid INT4,
    add BOOLEAN) RETURNS TEXT AS
$$
DECLARE
    ret    JSON;
BEGIN
    IF NOT check_user_is_admin(uid, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'Adder/Remover is not a group_admin');
    ELSE
      IF add THEN
        INSERT INTO "MemberOf" (group_id, member_id, access) VALUES (gid, mid, 'member');
      ELSE 
        DELETE FROM "MemberOf" WHERE member_id = mid AND group_id = gid;
      END IF;
      ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
