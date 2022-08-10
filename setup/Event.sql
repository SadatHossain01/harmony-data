CREATE TABLE "Event" (
    event_id       SERIAL
        CONSTRAINT event_pk
            PRIMARY KEY,
    time_created   TIMESTAMPTZ   DEFAULT CURRENT_TIMESTAMP,
    title          VARCHAR(30) DEFAULT 'Event'::CHARACTER VARYING,
    subject_id     INTEGER
        CONSTRAINT event_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE SET NULL,
    time_to_happen TIMESTAMPTZ
--     use TIMESTAMPTZ instead of TIMESTAMP
);

ALTER TABLE "Event"
    OWNER TO postgres;

CREATE UNIQUE INDEX event_event_id_uindex
    ON "Event" (event_id);

