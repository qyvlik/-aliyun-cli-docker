FROM alpine:3

ARG TIME_ZONE=Asia/Shanghai
ARG APK_REPOSITORIES=mirrors.aliyun.com
ARG ALIYUN_CLI_VERSION=3.0.123

RUN sed -i "s/dl-cdn.alpinelinux.org/${APK_REPOSITORIES}/g" /etc/apk/repositories

RUN apk add --update --no-cache tzdata curl wget bash git gettext jq \
    && echo "${TIME_ZONE}" > /etc/timezone \
    && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
    && rm -rf /var/cache/apk/*

WORKDIR /aliyun-cli

RUN curl -o "aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz" "https://aliyuncli.alicdn.com/aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz" \
    && tar xzvf "aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz" \
    && mv aliyun /usr/local/bin/aliyun \
    && chmod +x /usr/local/bin/aliyun
