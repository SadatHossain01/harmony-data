CREATE TABLE "Tag" (
    tag_id   SERIAL
        CONSTRAINT tag_pk
            PRIMARY KEY,
    tag_name VARCHAR(15) NOT NULL
);

ALTER TABLE "Tag"
    OWNER TO postgres;

CREATE UNIQUE INDEX tag_tag_id_uindex
    ON "Tag" (tag_id);

CREATE UNIQUE INDEX tag_tag_name_uindex
    ON "Tag" (tag_name);

