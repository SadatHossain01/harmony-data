CREATE TABLE "AssignedTo" (
    post_id INTEGER NOT NULL
        CONSTRAINT assignedto_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE SET NULL,
    user_id INTEGER NOT NULL
        CONSTRAINT assignedto_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT assignedto_pk
        PRIMARY KEY (post_id, user_id)
);

COMMENT ON TABLE "AssignedTo" IS 'queries will be assigned to one or more people';

ALTER TABLE "AssignedTo"
    OWNER TO postgres;
