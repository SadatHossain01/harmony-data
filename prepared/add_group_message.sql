-- $1 user_id
-- $2 group_id
-- $3 content
-- $4 content

-- PREPARE add_group_message(INT4, INT4, INT4, TEXT) AS
INSERT INTO "Message" (sender_id, group_id, subject_id, m_text)
      VALUES ($1::INT4, $2::INT4, $3::INT4, $4::TEXT)
      RETURNING prepare_json(json_build_object('message_id', message_id::text)::text);
