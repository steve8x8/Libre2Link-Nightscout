#!/usr/bin/make -f

# in "normal" usage mode, only sensors need to be updated
serial:	sensor clean

sensor: .settings data/sensors.json
	./json-upload

all: json upload tar clean

json:             data/sensors.json data/sgv-hist.json #data/sgv-real.json

upload: .settings data/sensors.json data/sgv-hist.json #data/sgv-real.json
	./json-upload

tar:
	mkdir -p SAVE
	LC_ALL=C tar cf SAVE/all-`date +%Y%m%d-%H%M%S`.tar data tmp log

clean:
	rm -rf tmp
	rm -rf data log


tmp/apps/com.freestylelibre.app.de/f/sas.db:
	./db-from-app

data/sensors.dump: tmp/apps/com.freestylelibre.app.de/f/sas.db
	./db-to-dump

data/sg-hist.dump: tmp/apps/com.freestylelibre.app.de/f/sas.db
	./db-to-dump

data/sg-real.dump: tmp/apps/com.freestylelibre.app.de/f/sas.db
	./db-to-dump

data/last-sensor.time: .settings
	./query-last-sensor

data/last-sgv-hist.time: .settings
	./query-last-sgv

#data/last-sgv-real.time: .settings
#	./query-last-sgv

data/sensors.json: data/sensors.dump data/last-sensor.time
	./dump-sensors-to-json

data/sgv-hist.json: data/sg-hist.dump data/last-sgv-hist.time
	./dump-sgv-to-json

#data/sgv-real.json: data/sg-real.dump data/last-sgv-real.time
#	./dump-sgv-to-json


.PHONY: serial sensor all json upload tar clean
