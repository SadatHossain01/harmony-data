CREATE OR REPLACE FUNCTION update_group_info(
    user_id INT4,
    gid INT4,
    name VARCHAR,
    gintro TEXT,
    photo_id INT 
  ) RETURNS TEXT AS
$$
DECLARE
    ret    JSON;
    sub_id INT4;
BEGIN
    IF NOT check_user_is_admin(user_id, gid) THEN
        ret := JSON_BUILD_OBJECT('success', false, 'reason', 'User is not an admin.');
    ELSE
      UPDATE "Group"
      SET group_name = name,
          intro = gintro
      WHERE group_id = gid;

      IF photo_id > 0 THEN
        UPDATE "Group"
        SET group_photo_id = photo_id
        WHERE group_id = gid;
      END IF;

      ret := JSON_BUILD_OBJECT('success', true);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
