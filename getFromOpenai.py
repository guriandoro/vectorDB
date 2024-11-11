#!/usr/bin/python3

import sys
from openai import OpenAI

client = OpenAI()

input = sys.argv[1]

''''
text-embedding-3-small
text-embedding-3-large
chatgpt-4o-latest
text-embedding-ada-002

'''
response = client.embeddings.create(input=input, model='text-embedding-3-small')
embeddings = [v.embedding for v in response.data]

for content, embedding in zip(input, embeddings):
    print(embedding)

