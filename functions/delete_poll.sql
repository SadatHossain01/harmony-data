CREATE OR REPLACE FUNCTION delete_poll(
    uid INT,
    pid INT
  ) RETURNS TEXT AS $$
DECLARE
  ret JSON;
  gid INT4;
BEGIN
  SELECT group_id INTO gid 
  FROM "Poll"
  WHERE poll_id = pid;

  IF NOT check_user_in_group(uid, gid) THEN
    ret := json_build_object('success', FALSE, 'reason', 'User not in group');
  ELSE 
    DELETE FROM "Poll"
    WHERE poll_id = pid; 
    ret := json_build_object('success', TRUE);
  END IF;
  return prepare_json(ret::text);
END;
$$ LANGUAGE plpgsql;
