-- Setup the SQL database
set client_encoding='utf8';

DROP DATABASE IF EXISTS stat_development;
DROP DATABASE IF EXISTS stat_test;

CREATE DATABASE stat_development;
CREATE DATABASE stat_test;

GRANT ALL PRIVILEGES ON DATABASE stat_development TO stat_user;
GRANT ALL PRIVILEGES ON DATABASE stat_test TO stat_user;

ALTER DATABASE stat_development OWNER  TO stat_user;
ALTER DATABASE stat_test OWNER TO stat_user;