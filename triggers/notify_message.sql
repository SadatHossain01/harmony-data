CREATE or replace TRIGGER tr_notify_message
    AFTER INSERT ON "Message"
    FOR EACH row EXECUTE FUNCTION notify_message();
