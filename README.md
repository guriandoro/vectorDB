## vectorDB

This docker container is intended to help setup and run an environment to learn and practice vector databases with a focus on pgvector. 
The container is not optimized for size but instead includes most of the tooling needed to get started withou having to build the env from scratch. 
This means the following is installed at a minimum.

* rocky linux 8
* postgres 16
* pgvector
* python 3.9
* bunch of needed python packages
* python scripts to generate embeddings using openai and minilm. ( Located in ```/``` ) 
* sample schema
* sample test data

**Note:** If using openai, you will need to generate an api key.  Visit https://platform.openai.com/api-keys for more details

### Sample data

I have added the sample data file to this repo it is 400MB. I used the lfs plugin for git.

The entry script will perform the following:

* Initiate the postgres db if its the first time running
* Set the postgres password to "postgres"
* Create a role named "vectordb" with a login password of "vectordb"
* Create a database called "vectordb" owned by "vectordb"
* Create the necessary tables inside the vectordb database
* Populate the tables using the ```vectordb_data.sql``` 

### Some postgres notes

* All entries in pg_hba.conf have all been set to trust
* The data directory is ```/pgdata/16/data```
* The data directory should be preserved even if you remove the container. Obviouldy removing the volume will deletethe data


### Building the image

The image takes a few minutes to build since there is a lot mojo in it.

```docker build -t vectordb .```


### To run the container ....

In the below example I am mapping port 6432 to the internal 5432 in the container. You can use whatever port you like

```docker run -p 6432:5432 --env=PGPASSWORD=postgres -v vectorDB:/pgdata --name vectorDB -d vectordb```

### Python embedding scripts are located  ...

```
/getFromMinilm.py
/getFromOpenai.py
```


### To remove the container and preserve any data in it

```docker stop vectorDB; docker rm vectorDB;```

### To remove the container volume 

Keep in mind removing container volume will permanatly delete data you may have saved and will require you 
to run the container again which will recreate the volume

```docker volume rm vectorDB```

### Any issues ??

Send me an email or message with issues or suggestions.
