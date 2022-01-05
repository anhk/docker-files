#!/bin/bash

# start monit
monit

# run COMMAND
exec "$@"
