CREATE OR REPLACE FUNCTION delete_event(
    uid INT,
    eid INT
) RETURNS TEXT AS
$$
DECLARE
    ret JSON;
    gid INT4;
BEGIN
    SELECT group_id
    INTO gid
    FROM "Event"
    WHERE event_id = eid;

    IF NOT check_user_is_admin(uid, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'User not a group admin');
    ELSE
        DELETE
        FROM "Event"
        WHERE event_id = eid;
        ret := JSON_BUILD_OBJECT('success', TRUE);
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
