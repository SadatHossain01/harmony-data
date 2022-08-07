CREATE TABLE "PollOption" (
    poll_id      INTEGER               NOT NULL
        CONSTRAINT polloption_poll_poll_id_fk
            REFERENCES "Poll"
            ON UPDATE CASCADE ON DELETE CASCADE,
    option_no    INTEGER               NOT NULL,
    option_title VARCHAR(35) DEFAULT 'Option'::CHARACTER VARYING,
    vote_count   INTEGER     DEFAULT 0 NOT NULL,
    CONSTRAINT polloption_pk
        PRIMARY KEY (poll_id, option_no),
    CONSTRAINT polloption_pk_2
        UNIQUE (poll_id, option_no)
);

COMMENT ON TABLE "PollOption" IS 'weak entity set dependent on poll';

ALTER TABLE "PollOption"
    OWNER TO postgres;

