psql -Upostgres < db/create_kodiak_users.sql &&
psql -Upostgres kodiak_test < db/search_extensions.sql &&
psql -Upostgres kodiak_dev < db/search_extensions.sql 
