CREATE OR REPLACE FUNCTION add_picture(owner_id INTEGER, link TEXT, type VARCHAR) RETURNS TEXT  AS $$
DECLARE
  cid INTEGER;
  ret JSON;
BEGIN
  INSERT INTO "Content"(type, link, owner_id)
  VALUES('Picture', link, owner_id)
  RETURNING content_id INTO cid;

  INSERT INTO "Picture"(picture_id, image_format)
  VALUES(cid, type);
  
  ret := json_build_object(
    'id', cid::text,
    'link', link::text
  );

  RETURN prepare_json(ret::text);
   
END;
$$ LANGUAGE plpgsql;
