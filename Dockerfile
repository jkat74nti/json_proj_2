# Vi använder en lättviktig Node-version som bas
FROM node:alpine

# Installera json-server globalt i containern
RUN npm install -g json-server

# Skapa en mapp för datan
WORKDIR /data

# Exponera porten som json-server körs på
EXPOSE 3000

# Kommandot som körs när containern startar
# --host 0.0.0.0 krävs för att kunna nå den utanför containern
ENTRYPOINT ["json-server", "--host", "0.0.0.0", "--watch", "db.json"]