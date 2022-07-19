CREATE TABLE "Content" (
    content_id   SERIAL
        CONSTRAINT content_pk
            PRIMARY KEY,
    type         VARCHAR(10)                                  NOT NULL,
    content_name VARCHAR(25) DEFAULT 'Content'::CHARACTER VARYING,
    access       VARCHAR(10) DEFAULT 'all'::CHARACTER VARYING NOT NULL,
    link         TEXT                                         NOT NULL,
    created      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    owner_id     INTEGER
        CONSTRAINT content_user__fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE SET NULL
);

COMMENT ON COLUMN "Content".type IS 'type is either file or photo';

ALTER TABLE "Content"
    OWNER TO postgres;

CREATE UNIQUE INDEX content_content_id_uindex
    ON "Content" (content_id);

CREATE UNIQUE INDEX content_link_uindex
    ON "Content" (link);

