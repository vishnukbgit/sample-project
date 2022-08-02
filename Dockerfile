FROM node:14.17.3
WORKDIR /app
COPY . .

ENV REACT_APP_API_URL "http://api.sidharth.com"

RUN npm i

EXPOSE 8000
RUN npm run build


CMD ["node","server.js"]
# ffdnmfemmfo
