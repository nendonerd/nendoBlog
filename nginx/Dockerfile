FROM nginx:alpine

# RUN apk add --update gettext && \
#   apk add --virtual build_deps libintl &&  \
#   cp /usr/bin/envsubst /usr/local/bin/envsubst && \
#   apk del build_deps

# COPY run.sh /usr/local/bin/run.sh
# COPY nginx.conf /etc/nginx/nginx.conf.template

# RUN chmod +x /usr/local/bin/run.sh

# CMD [ "run.sh" ]

# COPY ./cert/fullchain.pem /etc/nginx/https/fullchain.pem
# COPY ./cert/key.pem /etc/nginx/https/key.pem

COPY ./default.conf /etc/nginx/conf.d/default.conf

# VOLUME ["/etc/letsencrypt/live/nendo.ml/fullchain.pem", "/etc/letsencrypt/live/nendo.ml/privkey.pem", "/etc/letsencrypt/options-ssl-nginx.conf", "/etc/letsencrypt/ssl-dhparams.pem"]