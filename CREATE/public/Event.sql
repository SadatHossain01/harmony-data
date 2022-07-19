CREATE TABLE "Event" (
    event_id   SERIAL
        CONSTRAINT event_pk
            PRIMARY KEY,
    time       TIMESTAMP   NOT NULL,
    title      VARCHAR(30) NOT NULL,
    subject_id INTEGER     NOT NULL
        CONSTRAINT event_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE SET NULL
);

ALTER TABLE "Event"
    OWNER TO postgres;

CREATE UNIQUE INDEX event_event_id_uindex
    ON "Event" (event_id);

