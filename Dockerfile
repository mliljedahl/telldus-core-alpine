FROM alpine:3.17

# Compile telldus-core source
WORKDIR /usr/src/

COPY telldus /usr/src/telldus

RUN apk add --no-cache \
      confuse \
      libftdi1 \
      libstdc++ \
      socat

RUN apk add --no-cache --virtual .build-dependencies \
      confuse-dev \
      cmake \
      gcc \
      g++ \
      libftdi1-dev \
      libtool \
      make \
      musl-dev \
    && cd telldus/telldus-core \
    && cmake . -DBUILD_LIBTELLDUS-CORE=ON -DBUILD_TDADMIN=OFF -DBUILD_TDTOOL=ON -DFORCE_COMPILE_FROM_TRUNK=ON \
    && make -j$(nproc) \
    && make \
    && make install \
    && apk del .build-dependencies \
    && rm -rf /usr/src/telldus

COPY run.sh .

EXPOSE 50800-50801

CMD ["./run.sh"]

