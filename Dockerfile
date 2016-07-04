FROM alpine:edge
MAINTAINER Esra Fernau
RUN apk update
RUN apk add mongodb --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
VOLUME /data/db
VOLUME /mongodb/backup
ADD docker_entrypoint.sh /entrypoint.sh
EXPOSE 27017
CMD ["mongod"]


# Install node
ENV NODE_VERSION=v6.2.1 NPM_VERSION=3
RUN apk add --update git curl make gcc g++ python linux-headers libgcc libstdc++ binutils-gold && \
    curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz && \
    cd /node-${NODE_VERSION} && \
    ./configure --prefix=/usr --without-snapshot --fully-static && \
    make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    make install && \
    cd / && \
    npm install -g npm@${NPM_VERSION} && \
    apk del gcc g++ linux-headers libgcc libstdc++ binutils-gold && \
    rm -rf /etc/ssl /node-${NODE_VERSION} /usr/include \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
/usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html


# Install redis
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.1/main" >> /etc/apk/repositories && \
    apk add --update redis=2.8.23-r0 && \
    rm -rf /var/cache/apk/* && \
    chown -R redis:redis /data && \
    echo -e "include /etc/redis-local.conf\n" >> /etc/redis.conf

# Add the files
ADD root /

VOLUME ["/data"]

# Expose the ports for redis
EXPOSE 6379


RUN git config --global http.sslverify "false" &&\
    git clone https://github.com/xtremespb/taracotjs.git &&\
    cd /taracotjs/ &&\
    npm install &&\
    cd /bin/ &&\
    node install-system && node install-modules &&\
    node webserver 
