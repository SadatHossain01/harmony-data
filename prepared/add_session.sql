-- $1 session_id 
-- $2 user_id 
INSERT INTO "Session"(session_id, user_id)
VALUES($1::UUID, $2::INT4);
