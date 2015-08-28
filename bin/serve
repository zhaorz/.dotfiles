#!/usr/bin/env bash
#
# serve <port>
#
# Serve the current directory. Default port is 8000. Uses python's
# SimpleHTTPServer module.

if [ -z $1 ]
then        # no arguments
  open http://127.0.0.1:8000
  python -m SimpleHTTPServer 8000
else
  open http://127.0.0.1:$1
  python -m SimpleHTTPServer $1
fi
