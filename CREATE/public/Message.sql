CREATE TABLE "Message" (
    message_id  SERIAL
        CONSTRAINT message_pk
            PRIMARY KEY,
    m_text      TEXT                                NOT NULL,
    time        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sender_id   INTEGER                             NOT NULL
        CONSTRAINT message_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    receiver_id INTEGER                             NOT NULL
        CONSTRAINT message_user_user_id_fk_2
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE "Message"
    OWNER TO postgres;

CREATE UNIQUE INDEX message_message_id_uindex
    ON "Message" (message_id);

