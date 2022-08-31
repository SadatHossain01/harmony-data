
SELECT prepare_json(
  json_agg(
    json_build_object(
    'id', user_id::text,
    'user_name', user_name::text,
    'dp_link', c.link
    )
  )::text
) FROM "User" u
  LEFT JOIN "Content" c
  ON u.dp_id = c.content_id;
