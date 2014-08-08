CREATE USER kodiak_test WITH PASSWORD 'kodiak_test';
GRANT ALL PRIVILEGES ON DATABASE kodiak_test TO kodiak_test;
ALTER USER kodiak_test CREATEDB;
ALTER DATABASE kodiak_test OWNER TO kodiak_test;

CREATE USER kodiak_dev WITH PASSWORD 'kodiak_dev';
GRANT ALL PRIVILEGES ON DATABASE kodiak_dev TO kodiak_dev;
ALTER USER kodiak_test CREATEDB;
ALTER DATABASE kodiak_dev OWNER TO kodiak_dev;
