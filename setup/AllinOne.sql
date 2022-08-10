CREATE TABLE IF NOT EXISTS "User" (
    user_id   SERIAL
        CONSTRAINT user_pk
            PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    password  VARCHAR(20) NOT NULL,
    fname     VARCHAR(30) NOT NULL,
    mname     VARCHAR(30),
    lname     VARCHAR(30) NOT NULL,
    dob       DATE,
    joined    DATE DEFAULT CURRENT_DATE,
    dp_id     INTEGER
);

COMMENT ON COLUMN "User".fname IS 'first name';

COMMENT ON COLUMN "User".mname IS 'middle name, can be null';

COMMENT ON COLUMN "User".lname IS 'last name';



CREATE UNIQUE INDEX IF NOT EXISTS user_user_name_uindex
    ON "User" (user_name);

CREATE TABLE IF NOT EXISTS "Content" (
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



ALTER TABLE "User"
    ADD CONSTRAINT user_content_content_id_fk
        FOREIGN KEY (dp_id) REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE SET NULL;

CREATE UNIQUE INDEX IF NOT EXISTS content_content_id_uindex
    ON "Content" (content_id);

CREATE UNIQUE INDEX IF NOT EXISTS content_link_uindex
    ON "Content" (link);

CREATE TABLE IF NOT EXISTS "FriendOf" (
    user_1 INTEGER NOT NULL
        CONSTRAINT friendof_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    user_2 INTEGER NOT NULL
        CONSTRAINT friendof_user_user_id_fk_2
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT friendof_pk
        PRIMARY KEY (user_1, user_2),
    CONSTRAINT friendof_pk_2
        UNIQUE (user_1, user_2)
);

COMMENT ON TABLE "FriendOf" IS 'a recursive relation of user entity set';



CREATE TABLE IF NOT EXISTS "Group" (
    group_id       SERIAL
        CONSTRAINT group_pk
            PRIMARY KEY,
    group_name     VARCHAR(30) NOT NULL,
    intro          TEXT DEFAULT 'Welcome'::TEXT,
    created        DATE DEFAULT CURRENT_DATE,
    group_photo_id INTEGER
        CONSTRAINT group_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE SET NULL
);



CREATE UNIQUE INDEX IF NOT EXISTS group_group_id_uindex
    ON "Group" (group_id);

CREATE TABLE IF NOT EXISTS "MemberOf" (
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
        PRIMARY KEY (group_id, member_id),
    CONSTRAINT memberof_pk
        UNIQUE (group_id, member_id)
);

COMMENT ON TABLE "MemberOf" IS 'many-to-many relation between user and group';

COMMENT ON COLUMN "MemberOf".access IS 'member or admin';



CREATE TABLE IF NOT EXISTS "Subject" (
    subject_id      SERIAL
        CONSTRAINT subject_pk
            PRIMARY KEY,
    subject_name    VARCHAR(25) DEFAULT 'Subject'::CHARACTER VARYING NOT NULL,
    parent_group_id INTEGER                                          NOT NULL
        CONSTRAINT subject_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE UNIQUE INDEX IF NOT EXISTS subject_subject_id_uindex
    ON "Subject" (subject_id);

CREATE TABLE IF NOT EXISTS "Tag" (
    tag_id   SERIAL
        CONSTRAINT tag_pk
            PRIMARY KEY,
    tag_name VARCHAR(15) DEFAULT 'Tag'::CHARACTER VARYING NOT NULL
);



CREATE UNIQUE INDEX IF NOT EXISTS tag_tag_id_uindex
    ON "Tag" (tag_id);

CREATE UNIQUE INDEX IF NOT EXISTS tag_tag_name_uindex
    ON "Tag" (tag_name);

CREATE TABLE IF NOT EXISTS "Post" (
    post_id        SERIAL
        CONSTRAINT post_pk
            PRIMARY KEY,
    p_text         TEXT      DEFAULT 'Insert Post Here'::TEXT NOT NULL,
    time           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    upvote         INTEGER   DEFAULT 0                        NOT NULL,
    poster_id      INTEGER                                    NOT NULL
        CONSTRAINT post_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    parent_post_id INTEGER
        CONSTRAINT post_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    subject_id     INTEGER
        CONSTRAINT post_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE SET NULL,
    group_id       INTEGER
        CONSTRAINT post_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE
);

COMMENT ON COLUMN "Post".parent_post_id IS 'if parent post id null, then this is the root post';

COMMENT ON COLUMN "Post".subject_id IS 'if null, then general subject';



CREATE UNIQUE INDEX IF NOT EXISTS post_post_id_uindex
    ON "Post" (post_id);

CREATE UNIQUE INDEX IF NOT EXISTS post_text_uindex
    ON "Post" (p_text);

CREATE TABLE IF NOT EXISTS "Notice" (
    notice_id INTEGER NOT NULL
        CONSTRAINT notice_pk
            PRIMARY KEY
        CONSTRAINT notice_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    validity  TIMESTAMP
);

COMMENT ON TABLE "Notice" IS 'an inherited entity set of post';

COMMENT ON COLUMN "Notice".validity IS 'valid up until when';



CREATE UNIQUE INDEX IF NOT EXISTS notice_post_id_uindex
    ON "Notice" (notice_id);

CREATE TABLE IF NOT EXISTS "Query" (
    query_id INTEGER           NOT NULL
        CONSTRAINT query_pk
            PRIMARY KEY
        CONSTRAINT query_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    replies  INTEGER DEFAULT 0 NOT NULL
);

COMMENT ON TABLE "Query" IS 'an inherited entity set of post';



CREATE UNIQUE INDEX IF NOT EXISTS query_post_id_uindex
    ON "Query" (query_id);

CREATE TABLE IF NOT EXISTS "AssignedTo" (
    post_id INTEGER NOT NULL
        CONSTRAINT assignedto_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    user_id INTEGER NOT NULL
        CONSTRAINT assignedto_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT assignedto_pk
        PRIMARY KEY (post_id, user_id),
    CONSTRAINT assignedto_pk_2
        UNIQUE (post_id, user_id)
);

COMMENT ON TABLE "AssignedTo" IS 'queries will be assigned to one or more people';



CREATE TABLE IF NOT EXISTS "TagFallsUnder" (
    tag_id     INTEGER NOT NULL
        CONSTRAINT tagfallsunder_tag_tag_id_fk
            REFERENCES "Tag"
            ON UPDATE CASCADE ON DELETE CASCADE,
    subject_id INTEGER NOT NULL
        CONSTRAINT tagfallsunder_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT tagfallsunder_pk
        PRIMARY KEY (tag_id, subject_id),
    CONSTRAINT tagfallsunder_pk_2
        UNIQUE (tag_id, subject_id)
);

COMMENT ON TABLE "TagFallsUnder" IS 'many-to-many relation between Tag and Subject';



CREATE TABLE IF NOT EXISTS "PostRelatedTo" (
    tag_id  INTEGER NOT NULL
        CONSTRAINT postrelatedto_tag_tag_id_fk
            REFERENCES "Tag"
            ON UPDATE CASCADE ON DELETE CASCADE,
    post_id INTEGER NOT NULL
        CONSTRAINT postrelatedto_post_post_id_fk
            REFERENCES "Post"
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT postrelatedto_pk
        PRIMARY KEY (tag_id, post_id),
    CONSTRAINT postrelatedto_pk_2
        UNIQUE (tag_id, post_id)
);

COMMENT ON TABLE "PostRelatedTo" IS 'many-to-many relation between query and tag';

COMMENT ON COLUMN "PostRelatedTo".post_id IS 'this is of some query';



CREATE TABLE IF NOT EXISTS "Message" (
    message_id  SERIAL
        CONSTRAINT message_pk
            PRIMARY KEY,
    m_text      TEXT                                NOT NULL,
    time        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sender_id   INTEGER                             NOT NULL
        CONSTRAINT message_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    receiver_id INTEGER                             NOT NULL
        CONSTRAINT message_user_user_id_fk_2
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE UNIQUE INDEX IF NOT EXISTS message_message_id_uindex
    ON "Message" (message_id);

CREATE TABLE IF NOT EXISTS "GroupMessage" (
    message_id INTEGER NOT NULL
        CONSTRAINT groupmessage_pk
            PRIMARY KEY,
    group_id   INTEGER NOT NULL
        CONSTRAINT groupmessage_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE
);

COMMENT ON TABLE "GroupMessage" IS 'an inherited entity set of message';



CREATE UNIQUE INDEX IF NOT EXISTS groupmessage_message_id_uindex
    ON "GroupMessage" (message_id);

CREATE TABLE IF NOT EXISTS "Event" (
    event_id       SERIAL
        CONSTRAINT event_pk
            PRIMARY KEY,
    time_created   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    title          VARCHAR(30) DEFAULT 'Event'::CHARACTER VARYING,
    subject_id     INTEGER
        CONSTRAINT event_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE SET NULL,
    time_to_happen TIMESTAMPTZ
--  use TIMESTAMPTZ instead of TIMESTAMP
);



CREATE UNIQUE INDEX IF NOT EXISTS event_event_id_uindex
    ON "Event" (event_id);

CREATE TABLE IF NOT EXISTS "Assignment" (
    assignment_id    INTEGER NOT NULL
        CONSTRAINT assignment_pk
            PRIMARY KEY
        CONSTRAINT assignment_event_event_id_fk
            REFERENCES "Event"
            ON UPDATE CASCADE ON DELETE CASCADE,
    question_id      INTEGER NOT NULL
        CONSTRAINT assignment_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    subject_id       INTEGER
        CONSTRAINT assignment_subject_subject_id_fk
            REFERENCES "Subject"
            ON UPDATE CASCADE ON DELETE SET NULL,
    assignment_title VARCHAR(25) DEFAULT 'Assignment'::CHARACTER VARYING
);

COMMENT ON TABLE "Assignment" IS 'an inherited entity set of event';



CREATE UNIQUE INDEX IF NOT EXISTS assignment_event_id_uindex
    ON "Assignment" (assignment_id);

CREATE TABLE IF NOT EXISTS "Picture" (
    picture_id   INTEGER NOT NULL
        CONSTRAINT picture_pk
            PRIMARY KEY
        CONSTRAINT picture_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    image_format VARCHAR(10),
    dimension    VARCHAR(10),
    resolution   INTEGER
);

COMMENT ON TABLE "Picture" IS 'an inherited entity set of content';



CREATE UNIQUE INDEX IF NOT EXISTS picture_picture_id_uindex
    ON "Picture" (picture_id);

CREATE TABLE IF NOT EXISTS "File" (
    file_id       INTEGER     NOT NULL
        CONSTRAINT file_pk
            PRIMARY KEY
        CONSTRAINT file_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    file_format   VARCHAR(10) NOT NULL,
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE "File" IS 'an inherited entity set of content';



CREATE UNIQUE INDEX IF NOT EXISTS file_file_id_uindex
    ON "File" (file_id);

CREATE TABLE IF NOT EXISTS "Question" (
    question_id    SERIAL
        CONSTRAINT question_pk
            PRIMARY KEY,
    course_teacher VARCHAR(30),
    question_type  VARCHAR(15) NOT NULL,
    course         VARCHAR(15) NOT NULL,
    year           INTEGER,
    content_id     INTEGER
        CONSTRAINT question_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE,
    q_text         TEXT
);

COMMENT ON COLUMN "Question".question_type IS 'assignment or ct or term final?';

COMMENT ON COLUMN "Question".content_id IS 'look at the "questionIn" relation';

COMMENT ON COLUMN "Question".q_text IS 'if the question can be stored in a simple text format';



CREATE UNIQUE INDEX IF NOT EXISTS question_question_id_uindex
    ON "Question" (question_id);

CREATE TABLE IF NOT EXISTS "Solution" (
    question_id INTEGER           NOT NULL,
    s_text      TEXT,
    upvote      INTEGER DEFAULT 0 NOT NULL,
    solution_id INTEGER           NOT NULL
        CONSTRAINT solution_content_content_id_fk
            REFERENCES "Content"
            ON UPDATE CASCADE ON DELETE CASCADE
);

COMMENT ON TABLE "Solution" IS 'weak entity set dependent on question';

COMMENT ON COLUMN "Solution".s_text IS 'if the solution can be stored as a simple text, then why bother about files?';



CREATE TABLE IF NOT EXISTS "Poll" (
    poll_id     SERIAL
        CONSTRAINT poll_pk
            PRIMARY KEY,
    poll_title  VARCHAR(40) DEFAULT 'Poll'::CHARACTER VARYING NOT NULL,
    group_id    INTEGER                                       NOT NULL
        CONSTRAINT poll_group_group_id_fk
            REFERENCES "Group"
            ON UPDATE CASCADE ON DELETE CASCADE,
    poll_opened TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);



CREATE UNIQUE INDEX IF NOT EXISTS poll_poll_id_uindex
    ON "Poll" (poll_id);

CREATE TABLE IF NOT EXISTS "PollOption" (
    poll_id      INTEGER               NOT NULL
        CONSTRAINT polloption_poll_poll_id_fk
            REFERENCES "Poll"
            ON UPDATE CASCADE ON DELETE CASCADE,
    option_no    INTEGER               NOT NULL,
    option_title VARCHAR(35) DEFAULT 'Option'::CHARACTER VARYING,
    vote_count   INTEGER     DEFAULT 0 NOT NULL,
    CONSTRAINT polloption_pk
        PRIMARY KEY (poll_id, option_no),
    CONSTRAINT polloption_pk_2
        UNIQUE (poll_id, option_no)
);

COMMENT ON TABLE "PollOption" IS 'weak entity set dependent on poll';



CREATE TABLE IF NOT EXISTS "HasVoted" (
    voter_id  INTEGER NOT NULL
        CONSTRAINT hasvoted_user_user_id_fk
            REFERENCES "User"
            ON UPDATE CASCADE ON DELETE CASCADE,
    poll_id   INTEGER NOT NULL
        CONSTRAINT hasvoted_poll_poll_id_fk
            REFERENCES "Poll"
            ON UPDATE CASCADE ON DELETE CASCADE,
    vote_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT hasvoted_pk
        PRIMARY KEY (voter_id, poll_id),
    CONSTRAINT hasvoted_pk_2
        UNIQUE (poll_id, voter_id)
);

COMMENT ON TABLE "HasVoted" IS 'many-to-many relation between user and poll';

CREATE TABLE IF NOT EXISTS "Session"(
  session_id UUID NOT NULL PRIMARY KEY, 
  user_id INTEGER REFERENCES "User"(user_id));
