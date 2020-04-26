FROM alpine:latest

LABEL maintainer "LJason <https://ljason.cn>"

RUN apk add --no-cache --virtual .build-deps git gcc g++ build-base linux-headers cmake libressl-dev curl-dev rapidjson-dev libevent-dev pcre2-dev yaml-cpp-dev && \
    git clone --depth=1 https://github.com/LJason77/subconverter.git && \
    cd subconverter ; cmake . ; make -j2 && \
    mv subconverter base/ ; mv base ../ ; cd .. ; rm -rf subconverter && \
    apk add pcre2 libcurl yaml-cpp libevent && \
    apk del -qq --purge .build-deps && \
    rm -rf /var/cache/apk/*

WORKDIR /base

EXPOSE 25500

CMD ./subconverter
