FROM nginx:1.19.4-alpine

# 使用腾讯云内网镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencentyun.com/g' /etc/apk/repositories

RUN set -ex && \
  apk --no-cache add logrotate tzdata

# 设置时区
ENV TZ=Asia/Shanghai

COPY ./logrotate/nginx /etc/logrotate.d/nginx
RUN chmod 644 /etc/logrotate.d/nginx

CMD crond && nginx -g 'daemon off;'
