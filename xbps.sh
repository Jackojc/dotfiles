#!/usr/bin/env bash

. ./lib.sh

xbps-install -Syu $(sed 's/#.*//' < "notes/packages" | tr '\n' ' ' | sed 's/ \+/ /gp')
