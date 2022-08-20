CREATE OR REPLACE FUNCTION register_user_events(user_id INT4) RETURNS SETOF VARCHAR AS $$
DECLARE
  channel VARCHAR;
  gid INTEGER;
BEGIN
  FOR gid IN 
    SELECT group_id FROM "MemberOf"
    WHERE user_id = member_id 
  LOOP
    channel := 'chat/' || 'group/' || gid; 
    EXECUTE format('LISTEN %I', channel);
    RETURN NEXT channel;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
