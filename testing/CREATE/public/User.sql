CREATE TABLE "User" (
    user_id     SERIAL
        CONSTRAINT user_pk
            PRIMARY KEY,
    user_name   VARCHAR(20) NOT NULL,
    password    VARCHAR(20) NOT NULL,
    first_name  VARCHAR(30),
    middle_name VARCHAR(30),
    last_name   VARCHAR(30),
    joined      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE "User"
    OWNER TO postgres;

CREATE UNIQUE INDEX user_user_id_uindex
    ON "User" (user_id);

CREATE UNIQUE INDEX user_user_name_uindex
    ON "User" (user_name);

