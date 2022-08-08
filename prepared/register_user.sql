-- $1 user name
-- $2 password
-- $3 first name
-- $4 middle name
-- $5 last name
INSERT INTO "User" (user_name, password, first_name, middle_name, last_name)
  VALUES ($1::varchar, $2::varchar, $3::varchar, $4::varchar, $5::varchar);
