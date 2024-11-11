#!/usr/bin/python3

from sentence_transformers import SentenceTransformer
import sys

model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')

input = sys.argv[1]
embeddings = model.encode(input)
print(embeddings)

