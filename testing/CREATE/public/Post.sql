CREATE TABLE "Post" (
    post_id     SERIAL
        CONSTRAINT post_pk
            PRIMARY KEY,
    p_text      TEXT      DEFAULT 'Insert Post Here'::TEXT NOT NULL,
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_edited TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    poster_id   INTEGER                                    NOT NULL
        CONSTRAINT post_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    group_id    INTEGER                                    NOT NULL
        CONSTRAINT post_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE "Post"
    OWNER TO postgres;

CREATE UNIQUE INDEX post_post_id_uindex
    ON "Post" (post_id);

