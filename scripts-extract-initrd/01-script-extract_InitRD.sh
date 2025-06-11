#! /bin/bash

## ########################################################################## ##
## Extract inital Initial Ram Disk (InitRD or minirt)
##
## ########################################################################## ##
source ./init

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_extract_initrd(){ # initrd="$1" output_dir="$2"
  [ -d "$2" ] && return 1
  [ -d "$2/${EXTRACT_DIR_NAME}" ] || mkdir -p "$2/${EXTRACT_DIR_NAME}"
  sudo unmkinitramfs "$1" "$2/${EXTRACT_DIR_NAME}"
}

func_process(){
  local initrd dir

  for initrd in "${ORIGINALS[@]}"
  do
    echo "Extract ${initrd}:"
    dir=$(dirname "${initrd}")
    func_extract_initrd "${ORIGINALS_PATH}/${initrd}" "${EXTRACT_DIR}/${dir}"
  done
}

## -------------------------------------------------------------------------- ##
## MAIN
## -------------------------------------------------------------------------- ##
func_process

## -------------------------------------------------------------------------- ##
## Pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
