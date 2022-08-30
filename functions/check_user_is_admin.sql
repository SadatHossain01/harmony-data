CREATE OR REPLACE FUNCTION check_user_is_admin(
    uid INT4,
    gid INT4
) RETURNS BOOLEAN AS
$$
DECLARE
    valid BOOLEAN;
BEGIN
    valid :=
            EXISTS(
                    SELECT *
                    FROM "MemberOf" m
                    WHERE m.member_id = uid
                      AND m.group_id = gid
                      AND m.access = 'admin');
    RETURN valid;
END;
$$ LANGUAGE plpgsql;
