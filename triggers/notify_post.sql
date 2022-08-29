CREATE or replace TRIGGER tr_notify_post
    AFTER INSERT ON "Post"
    FOR EACH row EXECUTE FUNCTION notify_post();
