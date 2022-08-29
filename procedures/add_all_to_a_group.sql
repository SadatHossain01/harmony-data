CREATE OR REPLACE PROCEDURE add_member_to_group(
    gid INT4) AS
$$
DECLARE
    u RECORD;
BEGIN
    FOR u IN SELECT user_id FROM "User"
        LOOP
            IF NOT EXISTS(SELECT * FROM "MemberOf" WHERE group_id = gid AND member_id = u.user_id) THEN
                INSERT INTO "MemberOf"(group_id, member_id, access) VALUES (gid, u.user_id, 'member');
            END IF;
        END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL add_member_to_group(1);
