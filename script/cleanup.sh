#!/usr/bin/env sh

EXCLUDE_REGEX='^.+-(data|bundle)$'

echo "Deleting non-data-volume containers..."
docker ps -a -f status=created | grep -Ev "$EXCLUDE_REGEX" | awk 'NR > 1 {print $1}' | xargs -n 1 -I {} docker rm {}

echo "Deleting untagged images..."
IMAGES=$( docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)

if [ -n "$IMAGES" ]; then
  docker rmi $IMAGES    
fi
