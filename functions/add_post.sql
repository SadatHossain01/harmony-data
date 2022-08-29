CREATE OR REPLACE FUNCTION add_post(
  poster_id INT4,
  group_id INT4,
  subject_id INT4,
  parent_post_id INT4,
  ptype VARCHAR,
  content TEXT) RETURNS TEXT AS $$
DECLARE
  ret JSON;
  pid INT4;
BEGIN
  IF NOT check_group_subject(poster_id, group_id, subject_id) THEN
    ret := json_build_object('post_id', '-1', 'reason', 'User not in group or subject doesnt exist.');
  ELSE 
    INSERT INTO "Post" (poster_id, group_id, subject_id, parent_post_id, p_type, p_text)
          VALUES (poster_id, group_id, subject_id,  
            CASE parent_post_id 
              WHEN 0 THEN NULL
              ELSE parent_post_id 
            END,
            ptype, content
          )
          RETURNING post_id INTO pid;
    ret := json_build_object('post_id', pid::text);
  END IF;
  return prepare_json(ret::text);
END;
$$ LANGUAGE plpgsql;
