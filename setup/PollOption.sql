CREATE TABLE "PollOption" (
    poll_id      INTEGER               NOT NULL
        CONSTRAINT polloption_poll_poll_id_fk
            REFERENCES "Poll"
            ON UPDATE CASCADE ON DELETE CASCADE,
    option_id    SERIAL               NOT NULL,
    option_title VARCHAR(35) DEFAULT 'Option'::CHARACTER VARYING,
    option_description TEXT DEFAULT ''::TEXT,
    vote_count   INTEGER     DEFAULT 0 NOT NULL,
    CONSTRAINT polloption_pk
        PRIMARY KEY (option_id),
    CONSTRAINT polloption_pk_2
        UNIQUE (option_id)
);

COMMENT ON TABLE "PollOption" IS 'weak entity set dependent on poll';

