CREATE TABLE "Group" (
    group_id   SERIAL
        CONSTRAINT group_pk
            PRIMARY KEY,
    group_name VARCHAR(30) DEFAULT 'GROUP'::CHARACTER VARYING NOT NULL,
    intro      TEXT        DEFAULT 'Welcome'::TEXT,
    created    TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE "Group"
    OWNER TO postgres;

CREATE UNIQUE INDEX group_group_id_uindex
    ON "Group" (group_id);

