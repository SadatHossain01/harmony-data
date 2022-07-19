CREATE TABLE "MemberOf" (
    member_id INTEGER NOT NULL
        CONSTRAINT memberof_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    group_id  INTEGER NOT NULL
        CONSTRAINT memberof_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE,
    access    VARCHAR(10) DEFAULT 'normal'::CHARACTER VARYING,
    CONSTRAINT memberof_pk
        PRIMARY KEY (member_id, group_id)
);

ALTER TABLE "MemberOf"
    OWNER TO postgres;

