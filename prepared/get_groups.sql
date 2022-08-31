-- $1 user_id
-- PREPARE get_groups(INT4) AS
SELECT prepare_json(json_agg(gg)::text)
  FROM (
    SELECT g.group_id::text id, group_name name, m.access, intro, g.created created,
    group_photo_id::text image_id, c.link image_link,
        (
          SELECT json_agg(ss) FROM 
          (
            SELECT subject_id::text id, subject_name name FROM "Subject" s
            WHERE  s.parent_group_id = g.group_id
          ) ss
        ) subjects
        FROM "Group" g
        LEFT JOIN "Content" c
        ON g.group_photo_id = c.content_id
        JOIN "MemberOf" m
        ON m.group_id = g.group_id
        WHERE m.member_id = $1::INT
        ORDER BY created ASC
  ) gg;
