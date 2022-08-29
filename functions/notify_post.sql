CREATE OR REPLACE FUNCTION notify_post() RETURNS TRIGGER AS $$
DECLARE
  user_name VARCHAR;
  dp_link TEXT;
  payload JSON;
BEGIN

  SELECT u.user_name, c.link INTO user_name, dp_link
  FROM "User" u
  LEFT JOIN "Content" c
  ON u.dp_id = c.content_id
  WHERE user_id = NEW.poster_id;

  IF NEW.group_id IS NOT NULL THEN
    payload := json_build_object(
          'id', NEW.post_id::text,
          'group_id', NEW.group_id::text,
          'subject_id', NEW.subject_id::text,
          'parent_post_id', NEW.parent_post_id::text,
          'time', NEW.time::text,
          'poster_id', NEW.poster_id::text,
          'poster_name', user_name,
          'poster_dp_link', dp_link,
          'content', 
              json_build_object(
                'type', NEW.p_type,
                'data', NEW.p_text
              ),
          'comments', '[]'::json
        );

    PERFORM pg_notify('post/group/'|| NEW.group_id, prepare_json(payload::text));
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
