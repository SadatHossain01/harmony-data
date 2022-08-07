CREATE TABLE "Subject" (
    subject_id      SERIAL
        CONSTRAINT subject_pk
            PRIMARY KEY,
    subject_name    VARCHAR(25) DEFAULT 'Subject'::CHARACTER VARYING NOT NULL,
    parent_group_id INTEGER                                          NOT NULL
        CONSTRAINT subject_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE "Subject"
    OWNER TO postgres;

CREATE UNIQUE INDEX subject_subject_id_uindex
    ON "Subject" (subject_id);

