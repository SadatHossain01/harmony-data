CREATE or replace TRIGGER tr_notify_poll
    AFTER DELETE ON "Poll"
    FOR EACH row EXECUTE FUNCTION notify_poll();
