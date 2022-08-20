
-- PREPARE add_group_message (INT4, INT4, TEXT) AS
INSERT INTO "Message" (sender_id, receiver_id, m_text)
      VALUES ($1::INT4, $2::INT4, $3::TEXT);
