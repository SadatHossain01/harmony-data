CREATE TABLE "FriendOf" (
    user_1 INTEGER NOT NULL
        CONSTRAINT friendof_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE SET NULL,
    user_2 INTEGER NOT NULL
        CONSTRAINT friendof_user_user_id_fk_2
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT friendof_pk
        PRIMARY KEY (user_1, user_2)
);

COMMENT ON TABLE "FriendOf" IS 'a recursive relation of user entity set';

ALTER TABLE "FriendOf"
    OWNER TO postgres;

