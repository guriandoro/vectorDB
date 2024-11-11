#!/bin/bash

if [ ! -f "/pgdata/16/data/PG_VERSION" ]
then 
        # -- Some basic setup stuff ---
	sudo -u postgres /usr/pgsql-16/bin/initdb -D /pgdata/16/data
        echo "include = 'pg_custom.conf'" >> /pgdata/16/data/postgresql.conf
        cp /pg_custom.conf /pgdata/16/data/
        cp /pg_hba.conf /pgdata/16/data/
        cp /pgsqlProfile /var/lib/pgsql/.pgsql_profile
        chown postgres:postgres /var/lib/pgsql/.pgsql_profile
        chown postgres:postgres /pgdata/16/data/pg_custom.conf
        chown postgres:postgres /pgdata/16/data/pg_hba.conf
        sudo -u postgres /usr/pgsql-16/bin/pg_ctl -D /pgdata/16/data start

        ### --- Change postgres creds

	sudo -u postgres psql -c "ALTER ROLE postgres PASSWORD 'postgres';"

        ### --- Create the vectordb roles, extensions, schema

	sudo -u postgres psql -c "CREATE ROLE vectordb WITH LOGIN PASSWORD 'vectordb';"
        sudo -u postgres psql -c "CREATE database vectordb WITH OWNER vectordb;"
        sudo -u postgres psql vectordb -c "CREATE EXTENSION vector;"
	sudo -u postgres psql -U vectordb vectordb -f /vectordb_schema.sql

        ### --- excract the data files from gzip and load

        gzip -d /vectordb_data.sql.gz
	sudo -u postgres psql -U vectordb vectordb -f /vectordb_data.sql

else
        sudo -u postgres /usr/pgsql-16/bin/pg_ctl -D /pgdata/16/data start
fi

exec tail -f /dev/null
