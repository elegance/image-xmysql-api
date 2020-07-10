FROM node:10.14-alpine
LABEL maintainer="ouronghui<ouronghui@live.com>"

RUN npm config set unsafe-perm true \
    && npm install -g xmysql --registry=https://registry.npm.taobao.org \
    && npm cache clean --force \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

EXPOSE 3000
ENV DATASOURCE_URL=jdbc:mysql://127.0.0.1:3306/open_platform?characterEncoding=utf8&useSSL=true
ENV DATABASE_USER=root
ENV DATABASE_PASSWORD=xplat

COPY ["./docker-entrypoint.sh", "./docker-entrypoint.sh"]
ENTRYPOINT ["sh", "./docker-entrypoint.sh"]
