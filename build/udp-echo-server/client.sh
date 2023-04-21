#!/bin/bash

set -x

UDP_SERVER_IP="$1"

nping --udp -p 33333 $UDP_SERVER_IP -g 33334 --data-string "test" --count 1 -v3
