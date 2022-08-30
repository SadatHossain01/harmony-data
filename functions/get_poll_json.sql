CREATE OR REPLACE FUNCTION get_poll_json(
  uid INT,
  pid INT
) RETURNS JSON AS $$
DECLARE
  ret JSON;
  vote INT;
  cnt INT;
BEGIN
  IF uid IS NOT NULL THEN
    SELECT COUNT(*)  INTO cnt
    FROM "HasVoted"
    WHERE voter_id = uid
    AND   poll_id = pid;

    IF cnt > 0 THEN
      SELECT option_id INTO vote
      FROM "HasVoted"
      WHERE voter_id = uid
      AND   poll_id = pid;
    ELSE
      vote = -1;
    END IF;
  ELSE
    vote = -1;
  END IF;

  SELECT json_build_object(
      'id', p.poll_id::text,
      'title', p.poll_title,
      'total_vote', SUM(o.vote_count),
      'options', json_agg(
          json_build_object(
            'id', o.option_id::text,
            'poll_id', p.poll_id::text,
            'title', o.option_title,
            'description', o.option_description,
            'vote_count', o.vote_count,
            'width', 0
          )
      ),
      'voted_option', vote::text
    ) INTO ret
  FROM "Poll" p
  JOIN "PollOption" o
  ON p.poll_id = o.poll_id
  WHERE p.poll_id = pid
  GROUP BY p.poll_id, p.poll_title;
  
  return ret;
END;
$$ LANGUAGE plpgsql;

