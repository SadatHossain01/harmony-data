CREATE TABLE "Poll" (
    poll_id     SERIAL
        CONSTRAINT poll_pk
            PRIMARY KEY,
    poll_title  TEXT    DEFAULT                  'Poll'::TEXT NOT NULL,
    group_id    INTEGER                                       NOT NULL
        CONSTRAINT poll_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE,
    poll_opened TIMESTAMPTZ   DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX poll_poll_id_uindex
    ON "Poll" (poll_id);

