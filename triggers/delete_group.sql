CREATE or REPLACE TRIGGER tr_delete_group
    AFTER DELETE ON "Group"
    FOR EACH ROW EXECUTE FUNCTION delete_group();