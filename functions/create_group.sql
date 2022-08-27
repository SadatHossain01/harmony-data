CREATE OR REPLACE FUNCTION create_group(creator INT, name VARCHAR, intro TEXT, users INT[]) RETURNS TEXT  AS $$
DECLARE
  gid INT;
  ret TEXT;
BEGIN
  INSERT INTO "Group"(group_name, intro)
  VALUES(name, intro) RETURNING group_id INTO gid;

  INSERT INTO "MemberOf"
  VALUES(gid, creator, 'admin');

  INSERT INTO "MemberOf"
  SELECT gid, user_id, 'member'
  FROM "User"
  WHERE user_id = ANY(users)
  AND   user_id <> creator;

  ret := json_build_object(
    'id', gid::text
  );

  RETURN prepare_json(ret::text);
   
END;
$$ LANGUAGE plpgsql;
