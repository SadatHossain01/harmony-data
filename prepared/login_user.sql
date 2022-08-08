-- $1 username
-- $2 password

SELECT * FROM "User" 
WHERE $1::varchar = user_name
  AND $2::varchar = password;
