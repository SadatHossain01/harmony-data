CREATE OR REPLACE FUNCTION get_events(
    uid INT4,
    gid INT4
  ) RETURNS JSON AS
$$
DECLARE
    ret JSON;
BEGIN
    IF NOT check_user_in_group(uid, gid) THEN
      return '[]'::json;
    ELSE
      SELECT 
        json_agg(
          json_build_object(
          'id', event_id::text,
          'title', title, 
          'description', event_description::text,
          'time', time_to_happen::text
          )
          ORDER BY e.time_to_happen ASC
        ) INTO ret
       FROM "Event" e
       WHERE e.group_id = gid
       AND e.time_to_happen >= CURRENT_TIMESTAMP;
    END IF;
    IF ret IS NULL THEN
      return '[]'::json;
    ELSE
      return ret;
    END IF;
END;
$$ LANGUAGE plpgsql;
