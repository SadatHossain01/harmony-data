CREATE TABLE "Event" (
    event_id       SERIAL
        CONSTRAINT event_pk
            PRIMARY KEY,
    event_description TEXT       DEFAULT ''::TEXT NOT NULL;
    time_created   TIMESTAMPTZ   DEFAULT CURRENT_TIMESTAMP,
    title          VARCHAR(30) DEFAULT 'Event'::CHARACTER VARYING,
    group_id       INTEGER
        CONSTRAINT event_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE,
    time_to_happen TIMESTAMPTZ
--     use TIMESTAMPTZ instead of TIMESTAMP
);

CREATE UNIQUE INDEX event_event_id_uindex
    ON "Event" (event_id);

