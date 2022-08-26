-- $1 user_id

-- PREPARE get_user_info(INT4) AS
SELECT prepare_json(
  json_build_object(
    'id', user_id::text,
    'user_name', user_name,
    'first_name', fname,
    'middle_name', mname,
    'last_name', lname,
    'dob', dob::text,
    'joined', joined::text,
    'dp_id', dp_id::text,
    'dp_link', link::text 
  )::text
) FROM "User" u
  LEFT JOIN "Content" c 
  ON   u.dp_id = c.content_id
  WHERE user_id = $1::INT4;
