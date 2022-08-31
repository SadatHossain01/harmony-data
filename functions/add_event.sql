CREATE OR REPLACE FUNCTION add_event(
    user_id INT4,
    gid INT4,
    event_title VARCHAR,
    event_description TEXT,
    event_time TIMESTAMPTZ) RETURNS TEXT AS
$$
DECLARE
    ret JSON;
    eid INT4;
BEGIN
    IF NOT check_user_is_admin(user_id, gid) THEN
        ret := JSON_BUILD_OBJECT('event_id', '-1', 'reason', 'User is not an admin.');
    ELSE
        INSERT INTO "Event" (title, group_id, time_to_happen, event_description)
        VALUES (event_title, gid, event_time, event_description)
        RETURNING event_id INTO eid;
        ret := JSON_BUILD_OBJECT('event_id', eid::TEXT);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
