## vectorDB

This is a docker container running postgres16, pgvector, openai and minilm packages along with pythn3 and additional packages
needed to generate embeddings from openai or minilm using python scripts. I will add curl commands soon to do the same.

### Sample data

I will be adding a gz file containing sample data for pgvectore. I just need to get it on git since it is 400MB
The docker entry script will pre populate the database with the vector data the remove the gz file to clear up space


### Building the image

The image takes a few minutes to build since there is a lot in it

```docker build -t vectordb .```


### To run the container ....

```docker run -p 6432:5432 --env=PGPASSWORD=postgres -v vectorDB:/pgdata --name vectorDB -d vectordb```

### To remove the container and preserve any data in it

```docker stop vectorDB; docker rm vectorDB;```

### To remove the container volume 

Keep in mind removing container volume will permanatly delete data you may have saved and will require you 
to run the container again which will recreate the volume

```docker volume rm vectorDB```


