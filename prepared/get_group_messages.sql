-- $1 user_id
-- $2 group_id
-- $3 subject_id
-- PREPARE get_group_messages(INT4, INT4, INT4) AS
SELECT prepare_json(json_agg(messages)::TEXT)
  FROM(
    SELECT message_id::text, m_text AS content, time, sender_id::text, u1.user_name AS sender_name
      FROM "Message" m1
      JOIN "User" u1
      ON    u1.user_id = m1.sender_id 
      WHERE EXISTS(
            SELECT * FROM "MemberOf" m 
            WHERE m.member_id = $1::INT4
              AND m.group_id = $2::INT4)
        AND group_id = $2::INT4 
        AND subject_id = $3::INT4
      ORDER BY time ASC
  ) messages;
