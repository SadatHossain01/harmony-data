CREATE TABLE "File" (
    file_id       INTEGER     NOT NULL
        CONSTRAINT file_pk
            PRIMARY KEY
        CONSTRAINT file_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    file_format   VARCHAR(10) NOT NULL,
    last_modified TIMESTAMP   NOT NULL
);

COMMENT ON TABLE "File" IS 'an inherited entity set of content';

ALTER TABLE "File"
    OWNER TO postgres;

CREATE UNIQUE INDEX file_file_id_uindex
    ON "File" (file_id);

