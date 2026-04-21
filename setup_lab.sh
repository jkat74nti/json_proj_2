
 #!/bin/bash

IMAGE="cloture/json-server"
BASE_PORT=3100
TEMPLATE="student_data/template.json"

for i in {1..60}
do
  PORT=$((BASE_PORT + i))
  STUDENT_DB="student_data/db_student_$i.json"
  
  # 1. Skapa en unik kopia av datan för eleven om den inte redan finns
  if [ ! -f "$STUDENT_DB" ]; then
    cp "$TEMPLATE" "$STUDENT_DB"
  fi

  # 2. Starta containern
  docker run -d \
    --name "elev-server-$i" \
    -p "$PORT:3000" \
    -v "$(pwd)/$STUDENT_DB:/data/db.json" \
    --restart always \
    $IMAGE

  echo "Elev $i startad på port $PORT"
done
