#!/bin/bash

# ----------------------------------------------------------------------------------------------------------
# 0. Before running this initialization script:
#
# 0.1. create a new vm on GCP
#
# 0.2. set up ssh-key config:
# client$ `cat ~/.ssh/id_rsa.pub | pbcopy` , which will copy your client pubkey to clipboard. then you ssh to the server
# server$ `vim  ~/.ssh/authorized_keys`, which will create a new file, and paste the pubkey.
# GCP_console > metadata > ssh keys > paste your client pubkey into it
# mind for \n !!! ; And in both server and console, change pubkey's last field from client's username to server's username (you can check them by `echo $USER`)
# https://nabtron.com/gcc-mac-terminal/
#
# 0.3. buy a domain at godaddy, and set the domain name server to (at domain management panel)
# asa.ns.cloudflare.com
# jerry.ns.cloudflare.com
#
# 0.4. add site to cloudflare (for dns&cdn), in dns panel add record, then wait for dns update.
#       once dns updated, in crypto panel turn off ssl, turn off automatic-https-rewrite
#
# ---------------------------------------------------------------------------------------------------------


# 1. Install Docker
install_docker () {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $(users)
}
type docker || install_docker


# 2. Install Docker-Compose
install_docker-compose () {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}
type docker-compose || install_docker-compose


# 3. Gain Permission for Docker, so u don't have to use sudo for it
gain_permisson () {
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  sudo service docker restart
}
gain_permisson


# 4. Install Tools
install_tools () {
  type git || sudo apt-get install git -y
  type tree || sudo apt-get install tree -y
  type tmux || sudo apt-get install tmux -y
}
install_tools


# 5. Get tls cert
sudo docker run -it --rm --name certbot -p 80:80 -p 443:443 -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly
# select 1. temperary server method
# enter your domain name


# 6. Create /etc/letsencrypt/options-ssl-nginx.conf AND /etc/letsencrypt/ssl-dhparams.pem
sudo echo '
ssl_session_cache shared:le_nginx_SSL:1m;
ssl_session_timeout 1440m;

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;

ssl_ciphers "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS";
' > /etc/letsencrypt/options-ssl-nginx.conf

sudo openssl dhparam -out /etc/letsencrypt/ssl-dhparams.pem 2048


# 7. Clone the repo
mkdir nendoBlog
cd nendoBlog
git clone https://github.com/nendonerd/nendoBlog.git .

# 8. Create .env template
echo '
DEV_HOST=http://localhost:3000
DEV_CONTAINER_PORT=3000
DEV_HOST_PORT=3000

PRO_HOST=https://*****.**
PRO_CONTAINER_PORT=443
PRO_HOST_PORT=443
PRO_HOST_DOMAIN=*****.**

ISSO_HOST=http://0.0.0.0
ISSO_PORT=8080
SMTP_USER_NAME=*******@***.com
SMTP_PASSWORD=*********
SMTP_HOST=***.**.com
SMTP_PORT=465
SMTP_SECURITY=ssl
SMTP_TO=*******@***.com
SMTP_FROM=*******@***.com
' > .env

# -----------------------------------------------------------------------
# 9. Startup
# sudo docker-compose up -d --build

# 10. Turn on strict ssl policy
# Cloudflare -> crypto panel -> ssl: full; automatic-https-rewrite: true;
# -----------------------------------------------------------------------