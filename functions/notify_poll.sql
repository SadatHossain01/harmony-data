CREATE OR REPLACE FUNCTION notify_poll() RETURNS TRIGGER AS $$
DECLARE
  user_name VARCHAR;
  dp_link TEXT;
  payload JSON;
BEGIN
  IF (TG_OP = 'INSERT') THEN
    payload := json_build_object(
      'op', 'add',
      'id', NEW.poll_id::text,
      'poll', get_poll_json(NULL, NEW.poll_id)
    );
    PERFORM pg_notify('poll/group/'|| NEW.group_id, prepare_json(payload::text));
  ELSIF (TG_OP = 'DELETE') THEN
    payload := json_build_object(
      'op', 'delete',
      'id', OLD.poll_id::text
    );
    PERFORM pg_notify('poll/group/'|| OLD.group_id, prepare_json(payload::text));
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
