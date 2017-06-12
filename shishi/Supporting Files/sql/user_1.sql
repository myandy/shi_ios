CREATE TABLE IF NOT EXISTS "Writting" (
"id" integer PRIMARY KEY,
"text" text(128) NOT NULL,
"formerId" integer(128) NOT NULL,
"title" text(128) NOT NULL,
"create_dt" datetime DEFAULT(datetime('now', 'localtime')),
"update_dt" datetime DEFAULT(datetime('now', 'localtime')),
"bgImg" integer(128) NOT NULL,
"author" text(128)
);
