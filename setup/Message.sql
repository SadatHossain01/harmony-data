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
    receiver_id INTEGER                             
        CONSTRAINT message_user_user_id_fk_2
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    group_id INTEGER                                
        CONSTRAINT message_group_group_id_fk_3
            REFERENCES "Group"(group_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    subject_id INTEGER                                
        CONSTRAINT message_subject_subject_id_fk_4
            REFERENCES "Subject"(subject_id)
            ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE UNIQUE INDEX message_message_id_uindex
    ON "Message" (message_id);

