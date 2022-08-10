-- PREPARE create_group (VARCHAR, TEXT) AS
INSERT INTO "Group" (group_name, intro)
VALUES ($1::VARCHAR, $2::TEXT);

-- EXECUTE create_group('CSE19', 'Welcome to CSELand');
