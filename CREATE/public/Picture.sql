CREATE TABLE "Picture" (
    picture_id   INTEGER NOT NULL
        CONSTRAINT picture_pk
            PRIMARY KEY
        CONSTRAINT picture_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    image_format VARCHAR(10),
    dimension    VARCHAR(10),
    resolution   INTEGER
);

COMMENT ON TABLE "Picture" IS 'an inherited entity set of content';

ALTER TABLE "Picture"
    OWNER TO postgres;

CREATE UNIQUE INDEX picture_picture_id_uindex
    ON "Picture" (picture_id);

