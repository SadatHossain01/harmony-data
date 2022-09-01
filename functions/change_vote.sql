CREATE OR REPLACE FUNCTION change_vote(
    uid INT,
    pid INT,
    oid INT,
    add BOOLEAN
) RETURNS TEXT AS
$$
DECLARE
    ret     JSON;
    gid     INT4;
    d_oid   INT4;
    cnt     INT4;
    payload JSON;
BEGIN
    SELECT group_id
    INTO gid
    FROM "Poll"
    WHERE poll_id = pid;

    IF NOT check_user_in_group(uid, gid) THEN
        ret := JSON_BUILD_OBJECT('success', FALSE, 'reason', 'User not in group');
    ELSE
        IF NOT add THEN
            IF EXISTS(SELECT * FROM "HasVoted" WHERE poll_id = pid AND option_id = oid AND voter_id = uid) THEN
                DELETE
                FROM "HasVoted" v
                WHERE v.option_id = oid
                  AND v.voter_id = uid
                  AND v.poll_id = pid;

                UPDATE "PollOption" p
                SET vote_count = vote_count - 1
                WHERE p.poll_id = pid
                  AND p.option_id = oid;
            END IF;
        ELSE
            -- delete other vote
            SELECT COUNT(*)
            INTO cnt
            FROM "HasVoted" v
            WHERE v.voter_id = uid
              AND v.poll_id = pid;

            IF cnt > 0 THEN
                SELECT v.option_id
                INTO d_oid
                FROM "HasVoted" v
                WHERE v.voter_id = uid
                  AND v.poll_id = pid;

                DELETE
                FROM "HasVoted" v
                WHERE v.voter_id = uid
                  AND v.poll_id = pid
                  AND v.option_id = d_oid;

                UPDATE "PollOption" p
                SET vote_count = vote_count - 1
                WHERE p.poll_id = pid
                  AND p.option_id = d_oid;
            END IF;

            INSERT INTO "HasVoted"(voter_id, poll_id, option_id)
            VALUES (uid, pid, oid);

            UPDATE "PollOption" p
            SET vote_count = vote_count + 1
            WHERE p.poll_id = pid
              AND p.option_id = oid;
        END IF;

        ret := JSON_BUILD_OBJECT('success', TRUE);

        payload := JSON_BUILD_OBJECT(
                'op', 'update',
                'id', pid::TEXT,
                'group_id', gid::TEXT,
                'poll', get_poll_json(NULL, pid)
            );
        PERFORM pg_notify('poll/group/' || gid, prepare_json(payload::TEXT));
    END IF;
    RETURN prepare_json(ret::TEXT);
END;
$$ LANGUAGE plpgsql;
