urun:
	sudo /etc/init.d/postgresql start
	../elasticsearch-1.2.1/bin/elasticsearch &
	foreman start

uinstall:
	sudo apt-get install postgresql postgresql-contrib postgresql-doc
	sudo -u postgres createdb my_database_development
	sudo -u postgres createuser $$USER
	sudo apt-get libpq-dev