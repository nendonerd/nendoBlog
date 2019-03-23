FROM alpine:latest

ARG ISSO_VER=0.11.1

ENV GID=4242 UID=4242

# swap to mainland mirror

# RUN echo http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.8/main > /etc/apk/repositories; \
#   echo http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.8/community >> /etc/apk/repositories

# RUN rm -rf /var/cache/apk/* && \
#   rm -rf /tmp/*

# RUN apk update --no-cache

RUN apk -U upgrade \
  && apk add --no-cache -t build-dependencies \
  python-dev \
  libffi-dev \
  py2-pip \
  build-base \
  && apk --no-cache add \
  python \
  py-setuptools \
  sqlite \
  libressl \
  ca-certificates \
  su-exec \
  tini \
  && pip install --no-cache --upgrade pip \
  && pip install --no-cache cffi \
  && pip install --no-cache misaka==1.0.2 \
  && pip install --no-cache "isso==${ISSO_VER}" \
  && apk del build-dependencies \
  && rm -rf /tmp/*

# Install envsubst -> a tool to replace $xxx into env variable
RUN apk add --update gettext && \
  apk add --virtual build_deps libintl &&  \
  cp /usr/bin/envsubst /usr/local/bin/envsubst && \
  apk del build_deps

ARG HOST
ARG ISSO_HOST
ARG ISSO_PORT
ARG SMTP_USER_NAME
ARG SMTP_PASSWORD
ARG SMTP_HOST
ARG SMTP_PORT
ARG SMTP_SECURITY
ARG SMTP_TO
ARG SMTP_FROM

COPY isso.conf /isso/config/isso.conf.template

RUN envsubst < /isso/config/isso.conf.template > /isso/config/isso.conf

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 8080

VOLUME ["/isso/db", "/isso/log"]

CMD ["run.sh"]