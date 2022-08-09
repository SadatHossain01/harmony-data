CREATE TABLE IF NOT EXISTS Session(
  session_id UUID NOT NULL PRIMARY KEY, 
  user_id INTEGER REFERENCES "User"(user_id));
