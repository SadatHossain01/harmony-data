CREATE OR REPLACE FUNCTION prepare_json(str TEXT) RETURNS TEXT AS $$
DECLARE
  ret TEXT;
BEGIN
  IF str IS NULL THEN
    RETURN '[]';
  END IF;

  ret := replace(str, e'\n', '');
  IF (ret = '') THEN
    RETURN '[]';
  ELSE
    RETURN ret;
  END IF;
END;
$$ LANGUAGE plpgsql;
