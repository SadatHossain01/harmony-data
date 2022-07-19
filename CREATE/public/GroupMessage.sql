CREATE TABLE "GroupMessage" (
    message_id INTEGER NOT NULL
        CONSTRAINT groupmessage_pk
            PRIMARY KEY,
    group_id   INTEGER NOT NULL
        CONSTRAINT groupmessage_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE
);

COMMENT ON TABLE "GroupMessage" IS 'an inherited entity set of message';

ALTER TABLE "GroupMessage"
    OWNER TO postgres;

CREATE UNIQUE INDEX groupmessage_message_id_uindex
    ON "GroupMessage" (message_id);

