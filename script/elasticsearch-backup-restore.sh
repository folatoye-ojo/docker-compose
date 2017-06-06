#!/usr/bin/env sh

if [ -z "$1" ]; then
  backup_name="elasticsearch-$(date '+%Y-%m-%d')-backup.tar.gz"
  echo "Dumping elasticsearch data to tarball $(pwd)/$backup_name"

  docker run --rm \
    --volume dockercompose_elasticsearch-data:/usr/share/elasticsearch/data \
    --volume $(pwd):/backup busybox sh -c "cd /usr/share/elasticsearch && tar -czf /backup/$backup_name data"
else
  echo "Stopping elasticsearch container before importing data..."

  docker-compose stop elasticsearch

  file_only=$(basename "$1")
  echo "Mounting volume to host dir $(pwd) and using archive $file_only"

  docker run --rm \
    --volume dockercompose_elasticsearch-data:/usr/share/elasticsearch/data \
    --volume $(pwd):/backup \
    docker.elastic.co/elasticsearch/elasticsearch:5.3.0 \
    sh -c "rm -rf /usr/share/elasticsearch/data/* && cd /usr/share/elasticsearch/ && tar xf /backup/$file_only"
fi
