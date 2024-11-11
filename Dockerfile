FROM rockylinux:8

RUN \
  dnf -y update \
  && dnf install -y wget \
  && dnf install -y curl \
  && dnf install -y jq \
  && dnf install -y vim \
  && dnf install -y sudo \
  && dnf install -y gnupg \
  && dnf install -y procps-ng \
  && dnf install -y python39 \
  && dnf install -y less


RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN dnf -qy module disable postgresql
RUN dnf install -y postgresql16-server
RUN dnf install -y pgvector_16

RUN mkdir -p /pgdata/16/
RUN chown -R postgres:postgres /pgdata
RUN chmod 0700 /pgdata

COPY pg_custom.conf /
COPY pg_hba.conf /
COPY pgsqlProfile /
COPY getFromMinilm.py /
COPY getFromOpenai.py /
COPY packages.txt /
COPY vectordb_schema.sql /
COPY vectordb_data.sql.gz /

RUN pip3 install -U -r /packages.txt

EXPOSE 80
EXPOSE 5432

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh
RUN chmod +x /getFromMinilm.py
RUN chmod +x /getFromOpenai.py
RUN chmod +x /vectordb_data.sql.gz
RUN chmod +x /vectordb_schema.sql

SHELL ["/bin/bash", "-c"]
ENTRYPOINT /entrypoint.sh

