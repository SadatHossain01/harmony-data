
SELECT prepare_json(
  json_agg(
    json_build_object(
    'id', user_id::text,
    'user_name', user_name::text
    )
  )::text
) FROM "User";
