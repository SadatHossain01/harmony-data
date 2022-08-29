CREATE OR REPLACE FUNCTION change_vote(
    uid INT,
    pid INT,
    oid INT,
    add BOOLEAN
  ) RETURNS TEXT AS $$
DECLARE
  ret JSON;
  gid INT4;
  d_oid INT4;
  cnt INT4;
BEGIN
  SELECT group_id INTO gid 
  FROM "Poll"
  WHERE poll_id = pid;

  IF NOT check_user_in_group(uid, gid) THEN
    ret := json_build_object('success', FALSE, 'reason', 'User not in group');
  ELSE 
    IF NOT add THEN
      DELETE FROM "HasVoted" v
      WHERE v.option_id = oid
      AND v.voter_id = uid
      AND v.poll_id = pid;

      UPDATE "PollOption" p
      SET vote_count = vote_count - 1
      WHERE p.poll_id = pid
      AND p.option_id = oid;
    ELSE 
      -- delete other vote
      SELECT COUNT(*) INTO cnt
      FROM "HasVoted" v
      WHERE v.voter_id = uid
      AND v.poll_id = pid;

      IF cnt > 0 THEN
        SELECT v.option_id INTO d_oid
        FROM "HasVoted" v
        WHERE v.voter_id = uid
        AND v.poll_id = pid;

        DELETE FROM "HasVoted" v
        WHERE v.voter_id = uid
        AND v.poll_id = pid
        AND v.option_id = d_oid;

        UPDATE "PollOption" p
        SET vote_count = vote_count - 1
        WHERE p.poll_id = pid
        AND p.option_id = d_oid;
      END IF;

      INSERT INTO "HasVoted"(voter_id, poll_id, option_id)
      VALUES(uid, pid, oid);

      UPDATE "PollOption" p
      SET vote_count = vote_count + 1
      WHERE p.poll_id = pid
      AND p.option_id = oid;
    END IF;

    ret := json_build_object('success', TRUE);
  END IF;
  return prepare_json(ret::text);
END;
$$ LANGUAGE plpgsql;
