CREATE TABLE "Notice" (
    notice_id INTEGER NOT NULL
        CONSTRAINT notice_pk
            PRIMARY KEY
        CONSTRAINT notice_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    validity  TIMESTAMP
);

COMMENT ON TABLE "Notice" IS 'an inherited entity set of post';

COMMENT ON COLUMN "Notice".validity IS 'valid up until when';

ALTER TABLE "Notice"
    OWNER TO postgres;

CREATE UNIQUE INDEX notice_post_id_uindex
    ON "Notice" (notice_id);

