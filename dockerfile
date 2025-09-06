FROM node:14 

# WORKDIR /app 

COPY package.json .  

RUN npm install 

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]

# $ docker image ls
# $ docker run -p 3000:3000 <image_id>
