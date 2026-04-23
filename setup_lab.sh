#!/bin/bash

IMAGE="jkatnti/json_proj_2"
BASE_PORT=3100
TEMPLATE="student_data/db.json"

# Använd seq istället för {1..60} för bättre kompabilitet
for i in $(seq 1 60)
do
  PORT=$((BASE_PORT + i))
  STUDENT_DB="student_data/db_student_$i.json"
  
  if [ ! -f "$STUDENT_DB" ]; then
    cp "$TEMPLATE" "$STUDENT_DB"
  fi

  docker run -d \
    --name "elev-server-$i" \
    -p "$PORT:3100" \
    -v "$(pwd)/$STUDENT_DB:/data/db.json" \
    --restart always \
    $IMAGE

  echo "Elev $i startad på port $PORT"
done