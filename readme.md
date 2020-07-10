#### build image
```bash
docker build -t webdevelop/xmysql:0.1.0 .
docker login
docker push webdevelop/xmysql:0.1.0
```

#### run 
```
docker run -e "DATASOURCE_URL=jdbc:mysql://127.0.0.1:3306/mysql" -e "DATABASE_USER=root" -e "DATABASE_PASSWORD=root" -p 3000:3000 -d  webdevelop/xmysql:0.1.0
```

#### access
http://127.0.0.1:3000
