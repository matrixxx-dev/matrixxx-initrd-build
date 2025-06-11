#!/bin/bash

## ########################################################################## ##
##
## Build BusyBox (complete process)
##
## ########################################################################## ##
## includes:
. ./init

## defines:
CALL="true"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
[ -d "${BUILD_DIR}"/"${BUSYBOX_GIT_REPOSITORY_NAME}" ] \
  || ./00-script-get-busybox-repository.sh "$CALL"

./00-script-set-busybox-repository-default.sh "$CALL"
./01-script-build-busybox--transcription.sh "$CALL"
./02-script-build-busybox-pack.sh "$CALL"

## -------------------------------------------------------------------------- ##
## pause:
echo "CALLER: Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
