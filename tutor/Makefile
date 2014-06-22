urun:
	sudo /etc/init.d/postgresql start
	foreman start

uinstall:
	sudo apt-get install postgresql postgresql-contrib postgresql-doc
	sudo -u postgres createdb my_database_development
	sudo -u postgres createuser $$USER