CREATE OR REPLACE FUNCTION add_group_message(
  user_id INT4,
  group_id INT4,
  subject_id INT4) RETURNS INT4 AS $$
DECLARE
  ret JSON;
  msg_id INT4;
BEGIN
  IF NOT EXISTS(
        SELECT * FROM "MemberOf" m 
        WHERE m.member_id = user_id 
          AND m.group_id = group_id) THEN
    ret := json_build_object('id', '-1', 'reason', 'User not in group.');
  END IF;
    INSERT INTO "Message" (sender_id, group_id, subject_id, m_text)
          VALUES ($1::INT4, $2::INT4, $3::INT4, $4::TEXT)
          VALUES (user_id, group_id, subject_id, )
          RETURNING message_id INTO msg_id;
  ELSIF THEN
  END IF;
END;
$$ LANGUAGE plpgsql;
