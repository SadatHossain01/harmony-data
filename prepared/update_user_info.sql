-- $1 user_id
-- $2 user name
-- $3 password
-- $4 first name
-- $5 middle name
-- $6 last name
-- $7 dp_id 

UPDATE "User" 
SET user_name = $2::varchar,
    password  = $3::varchar,
    fname     = $4::varchar,
    mname     = $5::varchar,
    lname     = $6::varchar,
    dp_id     = CASE $7::INTEGER 
                  WHEN 0 THEN NULL
                  ELSE $7::INTEGER
                END
WHERE user_id = $1::INT4;
