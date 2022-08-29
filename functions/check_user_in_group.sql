CREATE OR REPLACE FUNCTION check_user_in_group(
  uid INT4,
  gid INT4
) RETURNS BOOLEAN AS $$
DECLARE
  valid BOOLEAN;
BEGIN
    valid :=
        EXISTS (
          SELECT * FROM "MemberOf" m
          WHERE m.member_id = uid
            AND m.group_id = gid);
    return valid;
END;
$$ LANGUAGE plpgsql;
