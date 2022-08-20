CREATE OR REPLACE FUNCTION check_message_group_subject(
  uid INT4,
  gid INT4,
  sid INT4) RETURNS BOOLEAN AS $$
DECLARE
  valid BOOLEAN;
BEGIN
    valid := gid IS NULL 
      OR (
        EXISTS (
          SELECT * FROM "MemberOf" m
          WHERE m.member_id = uid
            AND m.group_id = gid)
        AND 
        EXISTS (
          SELECT * FROM "Subject" s
          WHERE s.subject_id = sid
            AND s.parent_group_id = gid)
      );
    return valid;
END;
$$ LANGUAGE plpgsql;
