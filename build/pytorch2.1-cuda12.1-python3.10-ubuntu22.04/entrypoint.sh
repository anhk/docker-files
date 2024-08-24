#!/bin/bash

set -e

startJupyter() {
        echo "start jupyter $@"
        NOTEBOOK_BIN="jupyter lab"

        if [ ! -z "$HOSTIP" ]; then
                NOTEBOOK_ARGS="--ip=$HOSTIP $NOTEBOOK_ARGS"
        else
                NOTEBOOK_ARGS="--ip=0.0.0.0 $NOTEBOOK_ARGS"
        fi
        if [ ! -z "$NOTEBOOK_PORT" ]; then
                NOTEBOOK_ARGS="--port=$NOTEBOOK_PORT $NOTEBOOK_ARGS"
        fi
        if [ ! -z "$NOTEBOOK_DIR" ]; then
                NOTEBOOK_ARGS="--ServerApp.root_dir='$NOTEBOOK_DIR' $NOTEBOOK_ARGS"
        fi
        if [ -n "$BASE_URL" ]; then
                NOTEBOOK_ARGS="--ServerApp.base_url='$BASE_URL' $NOTEBOOK_ARGS"
        fi

        if [ -n "$NOTEBOOK_TOKEN" ]; then
                NOTEBOOK_ARGS="--IdentityProvider.token='$NOTEBOOK_TOKEN' $NOTEBOOK_ARGS"
        fi

        if [ -n "$PASSWORD" ]; then
                NOTEBOOK_ARGS="--ServerApp.allow_password_change=False $NOTEBOOK_ARGS"
                NOTEBOOK_ARGS="--ServerApp.password='$PASSWORD' $NOTEBOOK_ARGS"
        fi
        NOTEBOOK_ARGS="--allow-root $NOTEBOOK_ARGS"

        echo "Executing the command: $NOTEBOOK_BIN $NOTEBOOK_ARGS $@"
        exec $NOTEBOOK_BIN $NOTEBOOK_ARGS $@
}

startVScode() {
        echo "start vscode $@"
        NOTEBOOK_BIN="code-server"
        if [ ! -z "$HOSTIP" ]; then
                IP="$HOSTIP"
        else
                IP="0.0.0.0"
        fi
        if [ ! -z "$NOTEBOOK_PORT" ]; then
                ADDR="$IP:$NOTEBOOK_PORT"
        else
                ADDR="$IP:8888"
        fi
        NOTEBOOK_ARGS="--bind-addr=$ADDR $NOTEBOOK_ARGS"
        if [ ! -z "$NOTEBOOK_DIR" ]; then
                NOTEBOOK_ARGS="--user-data-dir='$NOTEBOOK_DIR' $NOTEBOOK_ARGS"
        fi
        if [ -n "$PROXY_DOMAIN" ]; then
                NOTEBOOK_ARGS="--proxy-domain='$PROXY_DOMAIN' $NOTEBOOK_ARGS"
        fi
        if [ -n "$PASSWORD" ]; then
                NOTEBOOK_ARGS="--auth password $NOTEBOOK_ARGS"
        fi
        if [ ! -z "$NOTEBOOK_TOKEN" ]; then
                export PASSWORD=$NOTEBOOK_TOKEN
        fi
        echo "Executing the command: $NOTEBOOK_BIN $NOTEBOOK_ARGS $@"
        exec $NOTEBOOK_BIN $NOTEBOOK_ARGS $@
}

if [ "$NOTEBOOK" == "vscode" ]; then
        startVScode $@
else
        startJupyter $@
fi
