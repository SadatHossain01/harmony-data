CREATE OR REPLACE FUNCTION add_group_message(
  user_id INT4,
  group_id INT4,
  subject_id INT4,
  content TEXT) RETURNS TEXT AS $$
DECLARE
  ret JSON;
  msg_id INT4;
BEGIN
  IF NOT check_group_subject(user_id, group_id, subject_id) THEN
    ret := json_build_object('message_id', '-1', 'reason', 'User not in group or subject doesnt exit.');
  ELSE 
    INSERT INTO "Message" (sender_id, group_id, subject_id, m_text)
          VALUES (user_id, group_id, subject_id, content)
          RETURNING message_id INTO msg_id;
    ret := json_build_object('message_id', msg_id::text);
  END IF;
  return prepare_json(ret::text);
END;
$$ LANGUAGE plpgsql;
