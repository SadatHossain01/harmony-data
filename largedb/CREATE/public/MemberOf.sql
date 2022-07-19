CREATE TABLE "MemberOf" (
    group_id  INTEGER                              NOT NULL
        CONSTRAINT memberof_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE,
    member_id INTEGER                              NOT NULL
        CONSTRAINT memberof_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    access    VARCHAR(10) DEFAULT 'member'::bpchar NOT NULL,
    CONSTRAINT member_pk
        PRIMARY KEY (group_id, member_id)
);

COMMENT ON TABLE "MemberOf" IS 'many-to-many relation between user and group';

COMMENT ON COLUMN "MemberOf".access IS 'member or admin';

ALTER TABLE "MemberOf"
    OWNER TO postgres;

