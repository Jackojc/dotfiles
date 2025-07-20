#!/usr/bin/env bash

. ./lib.sh

assert-root
xbps-install -Syu $(packages "xbps-packages")
