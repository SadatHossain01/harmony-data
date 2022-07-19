CREATE TABLE "Question" (
    question_id    SERIAL
        CONSTRAINT question_pk
            PRIMARY KEY,
    course_teacher VARCHAR(30),
    question_type  VARCHAR(15) NOT NULL,
    course         VARCHAR(15) NOT NULL,
    year           INTEGER,
    content_id     INTEGER
        CONSTRAINT question_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE SET NULL,
    q_text         TEXT
);

COMMENT ON COLUMN "Question".question_type IS 'assignment or ct or term final?';

COMMENT ON COLUMN "Question".content_id IS 'look at the "questionIn" relation';

COMMENT ON COLUMN "Question".q_text IS 'if the question can be stored in a simple text format';

ALTER TABLE "Question"
    OWNER TO postgres;

CREATE UNIQUE INDEX question_question_id_uindex
    ON "Question" (question_id);

