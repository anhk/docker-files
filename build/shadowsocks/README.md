
environment:
- $SS_PORT
- $SS_PASSWORD
- $SS_METHOD
- $OBFS_OPTS


```
docker run --env SS_PASSWORD="PASSWORD" -it --restart always -p 1445:1445 --name ss-server -d ir0cn/ss-server
```

