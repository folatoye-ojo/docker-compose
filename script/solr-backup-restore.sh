#!/usr/bin/env sh

if [ -z "$1" ]; then
  backup_name="solr-$(date '+%Y-%m-%d')-backup.tar.gz"
  echo "Dumping Solr data to tarball $(pwd)/$backup_name"

  docker run --rm --volumes-from solr-data -v $(pwd):/backup busybox sh -c "cd /opt/solr/server && tar -czf /backup/$backup_name solr"
else
  echo "Stopping Solr container before importing data..."

  docker-compose stop solr

  file_only=$(basename "$1")
  echo "Mounting volume to host dir $(pwd) and using archive $file_only"

  docker run --rm --volumes-from solr-data -v $(pwd):/backup solr:5.3.1 sh -c "rm -rf /opt/solr/server/solr/* && cd /opt/solr/server/ && tar xf /backup/$file_only"
fi
