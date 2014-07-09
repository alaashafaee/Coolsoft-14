urun: usearch
	sudo /etc/init.d/postgresql start
	foreman start

uinstall:
	sudo apt-get install postgresql postgresql-contrib postgresql-doc
	sudo -u postgres createdb my_database_development
	sudo -u postgres createuser $$USER
	sudo apt-get libpq-dev

usearch:
	../elasticsearch-1.2.1/bin/elasticsearch &

usearch-clean:
	rm -rf ../elasticsearch-1.2.1/data/elasticsearch/nodes/*
	rm -rf ../elasticsearch-1.2.1/logs/*

useed: usearch-clean usearch
	rake db:schema:load
	rake db:seed