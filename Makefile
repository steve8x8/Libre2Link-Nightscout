#!/usr/bin/make -f

all: json upload tar fullclean

json: data/sensors.json data/sgv-hist.json data/sgv-real.json

upload: data/sensors.json data/sgv-hist.json data/sgv-real.json .settings
	./json-upload

tar:
	mkdir -p SAVE
	LANG=C tar cf SAVE/all-`date +%Y%m%d-%H%M%S`.tar data tmp log

clean:
	rm -rf tmp

fullclean: clean
	rm -rf data log


tmp/apps/com.freestylelibre.app.de/db/sas.db:
	./db-from-app

data/sensors.dump:
	./db-to-dump

data/sg-hist.dump:
	./db-to-dump

data/sg-real.dump:
	./db-to-dump

data/last-sensor.time: .settings
	./query-last-sensor

data/last-sgv.time: .settings
	./query-last-sgv

data/sensors.json: data/sensors.dump data/last-sensor.time
	./dump-sensors-to-json

data/sgv-hist.json: data/sg-hist.dump data/last-sgv.time
	./dump-sgv-to-json

data/sgv-real.json: data/sg-real.dump data/last-sgv.time
	./dump-sgv-to-json


.PHONY: all json upload tar clean fullclean
