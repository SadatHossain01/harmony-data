-- $1 session_id 
-- $2 user_id 
SELECT user_id FROM "Session"
WHERE $1::UUID = session_id 
  AND $2::INT4 = user_id;
