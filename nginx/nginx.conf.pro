server {
	listen 80;
	listen [::]:80;
	server_name nendo.ml;
	return 301 https://nendo.ml$request_uri;

	access_log  /dev/null;
	error_log /dev/null;
}
server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name nendo.ml;

        if ($host = www.nendo.ml) {
                return 301 https://angristan.xyz$request_uri;
        }

	access_log /var/log/nginx/access.log;
	error_log  /var/log/nginx/error.log;

        ssl_certificate     /etc/nginx/https/fullchain.pem;
        ssl_certificate_key /etc/nginx/https/key.pem;

        ssl_protocols TLSv1.2;
        ssl_ecdh_curve X25519:P-521:P-384:P-256;
        ssl_ciphers EECDH+CHACHA20:EECDH+AESGCM:EECDH+AES;
        ssl_prefer_server_ciphers on;
        ssl_stapling on;
        ssl_stapling_verify on;
        resolver_timeout 5s;
        ssl_session_cache shared:SSL:10m;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload";

	location / {
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_pass http://127.0.0.1:2368;

	}

  location /isso {
    rewrite /isso/(.*) /$1  break;
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass http://127.0.0.1:8080;
  }
}