# Smart Home Deploy

智慧家庭的部署方法

## Docker-Compose

利用 Docker 运行程序

### 建立 Docker 容器网络

```shell
sudo docker network create website
```

### 配置

```shell
# 填写配置文件
cp .example.env .env
vi .env
```
