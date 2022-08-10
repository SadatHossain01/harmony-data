-- $1 event_name
-- $2 event_title
-- $3 subject_id

INSERT INTO "Event"(title, subject_id, time_to_happen)
	VALUES($1::VARCHAR, $2::INT4, $3::TIMESTAMPTZ);
