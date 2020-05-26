# Libre2Link-Nightscout: Extract L2 scan data from LL database, upload to NS

## Prerequisites:

- Android platform tools for your OS (for ''adb'', to be installed in ''$PATH'' or ''tools/'')
- Android Backup Extractor https://sourceforge.net/projects/adbextractor/ (''abe.jar'')
- Rename ''abe.sh'' in ''tools/'' to ''abe'', install ''abe.jar'' next to it
- Install ''sqlite3'', required to dump the database
- Install ''ruby'', needed to convert date/time representations in an OS-independent way

## How to do it:

- Connect your data collector smartphone
- Run ''adb devices'' to verify you've got access; confirm on Android device if necessary

- Apparently, opening the LibreLink app in the foreground may keep it from being stopped.

- Run ''db-from-app'' to backup the ''com.freestylelibre.app.de'' data, decompress and
  unpack the tree containing the database - intermediate files are removed on success

- VERY IMPORTANT: RESTART THE LIBRELINK APP TO AVOID DATA LOSS if it's no longer running!

- Run ''db-to-dump'' to extract sensor serials and glucose readings from the database

- Create ''.settings'' (using the template) with your Nightscout server data and credentials
- Run ''query-last-sensor'' to get the last "Sensor Change" treatment known to Nightscout
- Run ''query-last-sgv'' to get the timestamp of the last sgv reading submitted to Nightscout

- Run ''dump-to-sensors-json'' to convert the sensor list into an uploadable json file,
  selecting only events newer than the already known ones
- Run ''dump-to-sgv-json'' to convert both the 15-minute and manual-scan readings into
  an uploadable json file,
  selecting only events newer than the already known ones
  (there are no 1-minute readings if no bluetooth connection has been established!)

- Use ''json-upload'' to upload the (non-empty only) result files to Nightscout; logs are
  kept in logs/

- Archive: create a tarball in ''SAVE/'' of ''tmp/'', ''data/'' and ''log/''
- Clean up: remove whole ''tmp/'' subtree, possibly do the same with ''data/''

## Volume of data collected:

- The database storing the glucose values, ''sas.db'',  grows by about 10MB per month.

## Tested on:

- MacOSX 10.11.6, HomeBrew, Ruby 2.3.1
