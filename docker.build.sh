#!/bin/bash

POSTGRES_USER=root
POSTGRES_PASSWORD=root
POSTGRES_DB=instagram_post
POSTGRES_PORT=5432
POSTGRES_HOST=localhost

docker build -t instagram-post:latest \
  --build-arg POSTGRES_USER="$POSTGRES_USER" \
  --build-arg POSTGRES_DB="$POSTGRES_DB" \
  --build-arg POSTGRES_PORT="$POSTGRES_PORT" \
  --build-arg POSTGRES_HOST="$POSTGRES_HOST" \
  --build-arg POSTGRES_PASSWORD="$POSTGRES_PASSWORD" .

echo "Image 'instagram-post' built successfully!"

