CREATE TABLE "Solution" (
    question_id INTEGER           NOT NULL,
    s_text      TEXT,
    upvote      INTEGER DEFAULT 0 NOT NULL,
    solution_id INTEGER           NOT NULL
        CONSTRAINT solution_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE
);

COMMENT ON TABLE "Solution" IS 'weak entity set dependent on question';

COMMENT ON COLUMN "Solution".s_text IS 'if the solution can be stored as a simple text, then why bother about files?';

ALTER TABLE "Solution"
    OWNER TO postgres;

