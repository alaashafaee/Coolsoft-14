urun:
	sudo /etc/init.d/postgresql start
	foreman start

install:
	sudo apt-get install postgresql postgresql-contrib postgresql-doc
	sudo -u postgres createdb my_database_development
	sudo -u postgres createuser $$USER