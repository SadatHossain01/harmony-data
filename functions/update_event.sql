CREATE OR REPLACE FUNCTION update_event(
    user_id INT4,
    eid INT4,
    event_title VARCHAR,
    description TEXT,
    event_time TIMESTAMPTZ) RETURNS TEXT AS
$$
DECLARE
    ret JSON;
    gid INT4;
BEGIN
    SELECT group_id
    INTO gid
    FROM "Event"
    WHERE event_id = eid;
      
    IF NOT check_user_is_admin(user_id, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'User is not an admin.');
    ELSE
        UPDATE "Event"
        SET title             = event_title,
            event_description = description,
            time_to_happen    = event_time
        WHERE event_id = eid;
        ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
