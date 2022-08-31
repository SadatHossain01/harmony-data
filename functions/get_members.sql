CREATE OR REPLACE FUNCTION get_members(
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
          'id', user_id::text,
          'user_name', user_name::text,
          'dp_link', c.link
          )
        ) INTO ret
       FROM "User" u
        LEFT JOIN "Content" c
        ON u.dp_id = c.content_id
        JOIN "MemberOf" m
        ON u.user_id = m.member_id
        WHERE m.group_id = gid;
    END IF;
    IF ret IS NULL THEN
      return '[]'::json;
    ELSE
      return ret;
    END IF;
END;
$$ LANGUAGE plpgsql;
