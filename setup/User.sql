CREATE TABLE "User" (
    user_id   SERIAL
        CONSTRAINT user_pk
            PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    password  VARCHAR(30) NOT NULL,
    fname     VARCHAR(30) NOT NULL,
    mname     VARCHAR(30),
    lname     VARCHAR(30) NOT NULL,
    dob       DATE,
    joined    DATE DEFAULT CURRENT_DATE,
    dp_id     INTEGER
        CONSTRAINT user_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE SET NULL
);

COMMENT ON COLUMN "User".fname IS 'first name';

COMMENT ON COLUMN "User".mname IS 'middle name, can be null';

COMMENT ON COLUMN "User".lname IS 'last name';

CREATE UNIQUE INDEX user_user_name_uindex
    ON "User" (user_name);

