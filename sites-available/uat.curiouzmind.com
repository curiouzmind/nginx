# Prod server configuration
server {
	listen 80;
	listen [::]:80;

	server_name uat.curiouzmind.com;

	root /home/balade2/uat.curiouzmind.com;
	index index.php index.html index.htm index.nginx-debian.html;
        
	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

	# pass PHP scripts to FastCGI server
        #
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
       }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        location ~ /\.ht {
               deny all;
        }
}
