CREATE TABLE "PostRelatedTo" (
    tag_id  INTEGER NOT NULL
        CONSTRAINT postrelatedto_tag_tag_id_fk
            REFERENCES "Tag"
            ON UPDATE CASCADE ON DELETE SET NULL,
    post_id INTEGER NOT NULL
        CONSTRAINT postrelatedto_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT postrelatedto_pk
        PRIMARY KEY (tag_id, post_id)
);

COMMENT ON TABLE "PostRelatedTo" IS 'many-to-many relation between query and tag';

COMMENT ON COLUMN "PostRelatedTo".post_id IS 'this is of some query';

ALTER TABLE "PostRelatedTo"
    OWNER TO postgres;

