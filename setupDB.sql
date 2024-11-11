ALTER ROLE postgres PASSWORD 'postgres';

CREATE ROLE vectordb WITH LOGIN PASSWORD 'vectordb';
CREATE database vectordb WITH OWNER vectordb;

\c vectordb

CREATE EXTENSION vector;

\c vectordb

CREATE TABLE articles (
    id integer NOT NULL,
    url text,
    title text,
    content text
);


ALTER TABLE articles OWNER TO vectordb;

CREATE TABLE articles_minilm (
    id integer NOT NULL,
    title_vector vector(384),
    content_vector vector(384)
);


ALTER TABLE articles_minilm OWNER TO vectordb;


CREATE TABLE articles_openai (
    id integer NOT NULL,
    title_vector vector(1536),
    content_vector vector(1536),
    vector_id integer
);


ALTER TABLE articles_openai OWNER TO vectordb;


ALTER TABLE ONLY articles_minilm
    ADD CONSTRAINT articles_minilm_pkey PRIMARY KEY (id);

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_openai_pkey PRIMARY KEY (id);

ALTER TABLE ONLY articles_openai
    ADD CONSTRAINT articles_openai_pkey1 PRIMARY KEY (id);

\c vectordb

\i /vectordb_data.sql

