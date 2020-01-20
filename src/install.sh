#!/bin/bash

cat << EOF > /etc/nginx/sites-available/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                #index index.html index.htm default.aspx Default.aspx;
                root /var/www/default/;
                fastcgi_index /;
                fastcgi_pass 127.0.0.1:9000;
                include /etc/nginx/fastcgi_params;
        }
}
EOF

cat << EOF  >> /etc/nginx/fastcgi_params
fastcgi_param  PATH_INFO          "";
fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;

EOF

