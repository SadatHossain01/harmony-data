CREATE OR REPLACE FUNCTION add_poll(
    user_id INT,
    title VARCHAR(40),
    gid INT,
    options JSON
  ) RETURNS TEXT AS $$
DECLARE
  ret JSON;
  pid INT4;
BEGIN
  IF NOT check_user_in_group(user_id, gid) THEN
    ret := json_build_object('poll_id', '-1', 'reason', 'User not in group');
  ELSE 
    INSERT INTO "Poll" (poll_title, group_id)
          VALUES(title, gid)
          RETURNING poll_id INTO pid;

    INSERT INTO "PollOption"(poll_id, option_title, option_description)
    SELECT pid, x.title, x.description  
    FROM json_to_recordset(options) AS x(title VARCHAR, description TEXT);

    ret := json_build_object('poll_id', pid::text);
  END IF;
  return prepare_json(ret::text);
END;
$$ LANGUAGE plpgsql;
