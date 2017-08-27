

CREATE TABLE IF NOT EXISTS "UserCollection" (
"id" integer PRIMARY KEY,
"userId" text(128),
"poetryId" integer(128) NOT NULL,
"poetryName" text(128),
"create_dt" datetime DEFAULT(datetime('now', 'localtime'))
);
