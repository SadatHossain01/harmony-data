-- $1 user_id
-- PREPARE get_groups(INT4) AS
SELECT prepare_json(json_agg(gg)::text)
  FROM (
    SELECT group_id::text, group_name, intro, created,
        (
          SELECT json_agg(ss) FROM 
          (
            SELECT subject_id::text, subject_name FROM "Subject" s
            WHERE  s.parent_group_id = g.group_id
          ) ss
        ) subjects
        FROM "Group" g
        WHERE g.group_id IN (
          SELECT m.group_id FROM "MemberOf" m
          WHERE m.member_id = $1::INT4
        )
  ) gg;
