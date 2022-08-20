CREATE OR REPLACE FUNCTION create_general_subject() RETURNS TRIGGER AS
$$
BEGIN
    RAISE NOTICE 'group id: %', new.group_id;
    INSERT INTO "Subject" (subject_name, parent_group_id)
    VALUES ('General', new.group_id);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
