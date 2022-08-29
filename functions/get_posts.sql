CREATE OR REPLACE FUNCTION get_posts_json(
  uid INT4,
  gid INT4,
  sid INT4,
  parent_id INT4
) RETURNS JSON AS $$
DECLARE
  ret JSON;
BEGIN
    SELECT json_agg(
        json_build_object(
          'id', p.post_id::text,
          'time', p.time::text,
          'poster_id', p.poster_id::text,
          'poster_name', u.user_name,
          'poster_dp_link', c.link,
          'content', 
              json_build_object(
                'type', p.p_type,
                'data', p.p_text
              ),
          'comments', get_posts_json(uid, gid, sid, p.post_id)
        )
      ) INTO ret
    FROM      "Post" p
    JOIN      "User" u
    ON        p.poster_id = u.user_id
    LEFT JOIN "Content" c
    ON        u.dp_id = c.content_id
    WHERE     p.subject_id = sid
    AND       p.group_id   = gid
    AND       (
                parent_id IS NULL
                AND 
                p.parent_post_id IS NULL
              ) OR
              (
                parent_id IS NOT NULL
                AND 
                p.parent_post_id = parent_id 
              );
    IF ret IS NULL THEN
      return '[]'::json;
    ELSE 
      return ret;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_posts(
  uid INT4,
  gid INT4,
  sid INT4,
  parent_id INT4
) RETURNS TEXT AS $$
BEGIN
  IF parent_id = 0 THEN
    parent_id := NULL;
  END IF;

  IF check_group_subject(uid, gid, sid) THEN
    return get_posts_json(uid, gid, sid, parent_id)::text;
  ELSE
    return '[]'::text;
  END IF;
END;
$$ LANGUAGE plpgsql;
