CREATE OR REPLACE FUNCTION notify_message() RETURNS TRIGGER AS $$
DECLARE
  sender VARCHAR;
  sender_dp TEXT;
  payload JSON;
BEGIN

  SELECT user_name, c.link INTO sender, sender_dp
  FROM "User" u
  LEFT JOIN "Content" c
  ON u.dp_id = c.content_id
  WHERE user_id = NEW.sender_id;

  IF NEW.group_id IS NOT NULL THEN
    payload := json_build_object(
      'id', NEW.message_id::text,
      'sender_id', NEW.sender_id::text, 
      'sender_name', sender,
      'sender_dp', sender_dp,
      'content', NEW.m_text,
      'time', NEW.time::VARCHAR);
    PERFORM pg_notify('chat/group/'|| NEW.group_id, payload::text);
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
