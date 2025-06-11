#!/bin/bash

## ########################################################################## ##
##
## Build BusyBox
##
## ########################################################################## ##
## includes:
. ./init

## defines:
CALLEE="true"

CONFIG_LIST=(
## necessary:
CONFIG_STATIC
## add-on:
CONFIG_AR
CONFIG_FEATURE_AR_LONG_FILENAMES
CONFIG_FEATURE_AR_CREATE
CONFIG_UNCOMPRESS
CONFIG_UNLZOP
CONFIG_LZOPCAT
CONFIG_NUKE
CONFIG_TUNE2FS
CONFIG_MKFS_REISER
CONFIG_FLASH_ERASEALL
CONFIG_FLASH_LOCK
CONFIG_FLASH_UNLOCK
CONFIG_FLASHCP
CONFIG_INOTIFYD
CONFIG_ASH_BASH_SOURCE_CURDIR
CONFIG_HUSH_BASH_SOURCE_CURDIR
)

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## configure busybox compilation
func_configure_busybox(){ # git_repository="$1"; destination="$2"
  local git_repository destination
  git_repository="$1"; destination="$2"

  cd "${git_repository}" || exit 1
  make O="${destination}" defconfig
}

## configure busybox configuration
func_adapt_config_file(){ # config_file="$1"
  local element config_file
  config_file="$1"

  echo "config_file: ${config_file}"
  echo "activated values:"
  cp
  for element in "${CONFIG_LIST[@]}"
  do
    echo "  - ${element}"
    sed -i "s/# ${element} is not set/${element}=y/g" "${config_file}"
  done
}

## compile busybox
func_build_busybox(){ # destination="$1"
  local destination #cross_compile
  destination="$1"
  #cross_compile=""

  cd "${destination}" || exit 2
  make --jobs "$(nproc)"
#  make clean && make defconfig && \
#  make --jobs "$(nproc)" LDFLAGS="--static"
  #make --jobs "$(nproc)" CROSS_COMPILE="${cross_compile}" LDFLAGS="--static"
}

## generate root structure /bin/busybox /sbin /usr/bin /usr/sbin
## with corresponding sym. links
func_generate_busybox_structure(){
  make install
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## set and mkdir DESTINATION="obj/busybox-x86-v${version}"
func_set_and_mk_DESTINATION "${BUSYBOX_GIT_REPOSITORY_NAME}"

## build a busybox
DESTINATION="../${DESTINATION}"
func_configure_busybox "${BUSYBOX_GIT_REPOSITORY_NAME}" "${DESTINATION}" \
  && func_adapt_config_file "${DESTINATION}/.config" \
  && func_build_busybox "${DESTINATION}" \
  && func_generate_busybox_structure

## -------------------------------------------------------------------------- ##
## pause:
func_pause

## ########################################################################## ##
exit 0
