#!/bin/bash

## ########################################################################## ##
##
## set BusyBox repository
##
## ########################################################################## ##
## includes:
. ../lib/func_git-handling
. ./init

## defines:
CALLEE="$1"
RELEASE_BRANCH="1_37_stable"
#RELEASE_TAG="1_37_0"                  ## useful to generate a working branch
#                                      ## - if local changes are necessary

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## set local busybox git repository to default
cd busybox.git || exit 1
func_git_fetch
func_git_switch_to_branch "${RELEASE_BRANCH}"

## -------------------------------------------------------------------------- ##
## pause:
func_pause
## ########################################################################## ##
exit 0
