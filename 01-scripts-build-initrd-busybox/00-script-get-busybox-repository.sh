#!/bin/bash

## ########################################################################## ##
##
## get BusyBox repository
##
## ########################################################################## ##
## includes:
. ./init

## defines:
CALLEE="$1"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## generate local busybox git repository
## - MAIN_BRANCH="master"
git clone "${REMOTE_URL}" "${GIT_REPOSITORY_NAME}"

## -------------------------------------------------------------------------- ##
## pause:
func_pause

## ########################################################################## ##
exit 0
