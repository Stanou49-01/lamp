lamp
====
Usage
-----

To create the image `damienlagae/lamp`, execute the following command on the lamp folder:

	docker build -t damienlagae/lamp .


Running your LAMP docker image
------------------------------

Start your image binding the external ports 80 and 3306 in all interfaces to your container:

	docker run -d -p 80:80 -p 3306:3306 damienlagae/lamp

Test your deployment:

	Go to http://localhost/

Loading your custom PHP application
-----------------------------------

create a new `Dockerfile` in an empty folder with the following contents:

	FROM damienlagae/lamp:latest
	RUN rm -fr /var/www/html && git clone https://github.com/username/customapp.git /var/www/html
	EXPOSE 80 443 3306
	CMD ["/run.sh"]

replacing `https://github.com/username/customapp.git` with your application's GIT repository.
After that, build the new `Dockerfile`:

	docker build -t username/my-lamp-app .

And test it:

	docker run -d -p 80:80 -p 3306:3306 username/my-lamp-app

Test your deployment:

	Go to http://localhost/

That's it!


Connecting to the bundled MySQL server from within the container
----------------------------------------------------------------

The bundled MySQL server has a `root` user with password `toor` for local connections.
Simply connect from your PHP code with this user:

	<?php
	$mysql = new mysqli("localhost", "root", "toor");
	echo "MySQL Server info: ".$mysql->host_info;
	?>
