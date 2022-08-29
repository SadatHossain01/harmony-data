CREATE OR REPLACE FUNCTION get_polls(
  uid INT,
  gid INT
) RETURNS JSON AS $$
DECLARE
  ret JSON;
BEGIN
  IF NOT check_user_in_group(uid, gid) THEN
    return '[]'::text;
  ELSE
    SELECT json_agg(get_poll_json(uid, p.poll_id)) INTO ret
    FROM "Poll" p
    JOIN "MemberOf" m
    ON    p.group_id = m.group_id
    WHERE m.member_id = uid 
    AND   m.group_id = gid;

    return ret;
  END IF;
END;
$$ LANGUAGE plpgsql;
