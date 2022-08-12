CREATE or REPLACE TRIGGER tr_create_general_subject
    AFTER INSERT ON "Group"
    FOR EACH ROW EXECUTE FUNCTION create_general_subject();