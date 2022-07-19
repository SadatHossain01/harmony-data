CREATE TABLE "PostPartOf" (
    post_id  INTEGER NOT NULL
        CONSTRAINT postpartof_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    group_id INTEGER NOT NULL
        CONSTRAINT postpartof_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT postpartof_pk
        PRIMARY KEY (post_id, group_id),
    CONSTRAINT postpartof_pk_2
        UNIQUE (post_id, group_id)
);

COMMENT ON TABLE "PostPartOf" IS 'to know which group this post is of';

ALTER TABLE "PostPartOf"
    OWNER TO postgres;

