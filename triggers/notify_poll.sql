CREATE or replace TRIGGER tr_notify_poll
    AFTER INSERT OR DELETE ON "Poll"
    FOR EACH row EXECUTE FUNCTION notify_poll();
