-- $1 poster_id
-- $2 group_id
-- $3 post_text

-- PREPARE add_post (INT4, INT4, TEXT) AS
INSERT INTO "Post" (p_text, poster_id, group_id)
      VALUES ($3::TEXT, $1::INT4, $2::INT4);

-- EXECUTE add_post('Hi? How are you all?', 'Sadat999', 'CSE19');
