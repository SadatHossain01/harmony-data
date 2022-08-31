CREATE OR REPLACE FUNCTION update_poll(
    uid INT,
    pid INT,
    title TEXT,
    options JSON
  ) RETURNS TEXT AS $$
DECLARE
  ret JSON;
  gid INT4;
  payload JSON;
BEGIN
  SELECT group_id INTO gid 
  FROM "Poll"
  WHERE poll_id = pid;
  IF NOT check_user_in_group(uid, gid) THEN
    ret := json_build_object('success', FALSE, 'reason', 'User not in group');
  ELSE 

    UPDATE "Poll"
    SET poll_title = title
    WHERE poll_id = pid;

    DELETE FROM "PollOption" p
    WHERE option_id IN 
    (
      (
        SELECT p2.option_id FROM "PollOption" p2
        WHERE p2.poll_id = pid
      ) 
      EXCEPT
      (
        SELECT x.id FROM json_to_recordset(options) AS x(id INT)
      )
    );

    INSERT INTO "PollOption"(poll_id, option_title, option_description)
    SELECT pid, x.title, x.description  
    FROM json_to_recordset(options) AS x(id INT, title VARCHAR, description TEXT)
    WHERE x.id = 0;

    UPDATE "PollOption" p
    SET option_title = x.title,
        option_description = x.description
    FROM json_to_recordset(options) AS x(id INT, title VARCHAR, description TEXT)
    WHERE p.option_id = x.id
    AND p.poll_id = pid;

    ret := json_build_object('success', TRUE);

    payload := json_build_object(
      'op', 'update',
      'id', pid::text,
      'group_id', gid::text,
      'poll', get_poll_json(NULL, pid)
    );
    PERFORM pg_notify('poll/group/'|| gid, prepare_json(payload::text));
  END IF;
  return prepare_json(ret::text);
END;
$$ LANGUAGE plpgsql;
