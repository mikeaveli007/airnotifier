#!/bin/bash
set -e

export LOGDIR=/var/log/airnotifier
export LOGFILE=$LOGDIR/airnotifier.log
export LOGFILE_ERR=$LOGDIR/airnotifier.err

if [ ! -f "./config.py" ]; then
  cp config.py-sample config.py
fi

if [ ! -f "./logging.ini" ]; then
  cp logging.ini-sample logging.ini
fi

if [ ! -f "$LOGFILE" ]; then
  touch "$LOGFILE"
fi

if [ ! -f "$LOGFILE_ERR" ]; then
  touch "$LOGFILE_ERR"
fi

echo "Installing AirNotifier ..."
pipenv run ./install.py
echo "Starting AirNotifier ..."
#pipenv run ./app.py >> "$LOGFILE" 2>> "$LOGFILE_ERR"
pipenv run ./app.py 2>> "$LOGFILE_ERR"