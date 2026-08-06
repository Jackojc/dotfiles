#!/usr/bin/env bash

. ./lib.sh

assert_root
xbps-install -Syu $(packages "xbps-packages")
