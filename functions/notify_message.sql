CREATE OR REPLACE FUNCTION notify_message() RETURNS TRIGGER AS $$
DECLARE
  sender VARCHAR;
  payload JSON;
BEGIN

  SELECT user_name INTO sender 
  FROM "User"
  WHERE user_id = NEW.sender_id;

  IF NEW.group_id IS NOT NULL THEN
    payload := json_build_object(
      'sender_id', NEW.sender_id, 
      'sender_name', sender,
      'content', NEW.m_text,
      'time', NEW.time::VARCHAR);
    PERFORM pg_notify('chat/group/'|| NEW.group_id, payload::text);
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
