FROM node:26

# env vars are set
ENV PORT=5000
ENV DATABASE_URL=postgresql://postgres:root@localhost:5432/blog
ENV JWT_SECRET=5cb81a8d5563b0b5b9e2f2ffd2b26c19889aa0362c40378ad5145612abc6009d

#AWS - floci setup is needed beforehand
ENV AWS_ACCESS_KEY_ID=test
ENV AWS_SECRET_ACCESS_KEY=test
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_REGION=us-east-1

# only for local AWS emulators
ENV AWS_ENDPOINT_URL=http://localhost:4566 

ENV S3_BUCKET=blog-storage

# SQS
ENV SQS_QUEUE_URL=http://localhost:4566/000000000000/s3-upload-events

EXPOSE ${PORT}

WORKDIR /blog-api

COPY package.json package-lock.json ./

RUN npm install --force

COPY . .

RUN npm run build

ENTRYPOINT ["node"]

CMD ["dist/index.js"]