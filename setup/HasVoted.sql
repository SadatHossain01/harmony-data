CREATE TABLE "HasVoted" (
    voter_id  INTEGER NOT NULL
        CONSTRAINT hasvoted_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    poll_id   INTEGER NOT NULL
        CONSTRAINT hasvoted_poll_poll_id_fk
            REFERENCES "Poll"
            ON UPDATE CASCADE ON DELETE CASCADE,
    option_id   INTEGER NOT NULL
        CONSTRAINT hasvoted_option_option_id_fk
            REFERENCES "PollOption"
            ON UPDATE CASCADE ON DELETE CASCADE,
    vote_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT hasvoted_pk
        PRIMARY KEY (voter_id, poll_id),
    CONSTRAINT hasvoted_pk_2
        UNIQUE (poll_id, voter_id)
);

COMMENT ON TABLE "HasVoted" IS 'many-to-many relation between user and poll';

