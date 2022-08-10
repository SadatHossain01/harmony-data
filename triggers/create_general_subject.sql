CREATE or replace TRIGGER tr_create_general_subject
    AFTER INSERT ON "Group"
    FOR EACH row EXECUTE FUNCTION create_general_subject();