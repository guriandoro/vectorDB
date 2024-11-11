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

        # -- Prime the vectordb env with users and data 

        gzip -d /vectordb_data.sql.gz 
        sudo -u postgres psql -f /setupDB.sql

else
        sudo -u postgres /usr/pgsql-16/bin/pg_ctl -D /pgdata/16/data start
fi

exec tail -f /dev/null
