#!/bin/bash

## ########################################################################## ##
##
## get other c-libraries
##
## ########################################################################## ##
## includes:
. ./init

## defines:
CALLEE="true"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## home page: https://musl.libc.org/
## online git: https://git.musl-libc.org/cgit/musl
## - MAIN_BRANCH="master"
#git clone git://git.musl-libc.org/musl musl.git

## home page: https://www.uclibc-ng.org/
## online git: https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/
## - MAIN_BRANCH="master"
#git clone git://uclibc-ng.org/git/uclibc-ng uclibc-ng.git

## -------------------------------------------------------------------------- ##
## pause:
func_pause

## ########################################################################## ##
exit 0
