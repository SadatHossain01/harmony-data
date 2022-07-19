CREATE TABLE "Query" (
    query_id INTEGER           NOT NULL
        CONSTRAINT query_pk
            PRIMARY KEY
        CONSTRAINT query_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE SET NULL,
    replies  INTEGER DEFAULT 0 NOT NULL
);

COMMENT ON TABLE "Query" IS 'an inherited entity set of post';

ALTER TABLE "Query"
    OWNER TO postgres;

CREATE UNIQUE INDEX query_post_id_uindex
    ON "Query" (query_id);

