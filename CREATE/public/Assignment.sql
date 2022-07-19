CREATE TABLE "Assignment" (
    assignment_id    INTEGER NOT NULL
        CONSTRAINT assignment_pk
            PRIMARY KEY
        CONSTRAINT assignment_event_event_id_fk
            REFERENCES "Event"
            ON UPDATE CASCADE ON DELETE CASCADE,
    question_id      INTEGER NOT NULL
        CONSTRAINT assignment_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    subject_id       INTEGER NOT NULL
        CONSTRAINT assignment_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE SET NULL,
    assignment_title VARCHAR(25)
);

COMMENT ON TABLE "Assignment" IS 'an inherited entity set of event';

ALTER TABLE "Assignment"
    OWNER TO postgres;

CREATE UNIQUE INDEX assignment_event_id_uindex
    ON "Assignment" (assignment_id);

