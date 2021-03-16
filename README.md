# Smart Home Deploy

智慧家庭的部署方法

## Docker-Compose

利用 Docker 运行程序

### IPv6

转发 Docker 容器网络

```shell
sudo ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
```

### 配置

```shell
# 填写配置文件
cp .example.env .env
vi .env
```

### 创建文件夹

```shell
mkdir smart-home/logs
mkdir smart-home/static
mkdir blog/typecho
```

### [智慧家庭](https://github.com/he0119/smart-home)

1. 根据部署方法

    ```shell
    sudo docker-compose up smart-home
    sudo docker exec smart-home python manage.py collectstatic
    sudo docker exec smart-home python manage.py migrate
    sudo docker exec -it smart-home python manage.py createsuperuser
    ```

### [Typecho](https://github.com/typecho/typecho)

1. 下载 typecho 文件至 blog/typecho 中

    ```shell
    git clone https://github.com/he0119/typecho.git blog/typecho
    ```

1. 建立 typecho 数据库

    ```shell
    sudo docker exec -it postgres psql -U postgres
    create database typecho;
    ```

### Nginx

1. 先申请证书

    注释 docker-compose.yml 中这两行

    ```yml
    # - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    # - ./nginx/sites:/etc/nginx/conf.d:ro
    ```

    填写并运行 `./acme.sh/issue-and-deploy-ssl-key.sh`

1. 启动服务器

    ```shell
    sudo docker-compose up -d
    ```

## 依赖

以下为智慧家庭部署所需软件

- [Nginx](https://hub.docker.com/_/nginx)
- [acme.sh](https://hub.docker.com/r/neilpang/acme.sh)
- [EMQX](https://hub.docker.com/r/emqx/emqx)
- [PostgreSQL](https://hub.docker.com/_/postgres)
- [redis](https://hub.docker.com/_/redis)
- [PHP](https://hub.docker.com/_/php)
- [typecho](https://github.com/typecho/typecho)

### PostgreSQL

升级步骤

```shell
# 备份
sudo docker exec postgres pg_dumpall -U postgres > backup.sql
# 复制备份文件进容器
sudo docker cp backup.sql postgres:/backup.sql
# 恢复
sudo docker exec postgres psql -U postgres -f /backup.sql
```
