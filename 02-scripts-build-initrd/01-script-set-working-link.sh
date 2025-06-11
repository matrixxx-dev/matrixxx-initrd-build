#! /bin/bash

## ########################################################################## ##
##
## generate working dir link
##
## ########################################################################## ##
## includes
source ./init

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## create a working link
func_gen_working_dir_link(){ # dir="$1"; link="$2"
  local dir link
  dir="$1"; link="$2"
  ## remove existing link
  [ -d "${link}" ] && rm -f "${link}"
  ## bild new link
  ln -s "${dir}" "${link}"
  echo "- ${link} -> ${dir}"
}

## -------------------------------------------------------------------------- ##
## MAIN
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## check if process is possible
## - a version of the working directory exists yet
if func_check_dir "${WORKING_DIR_NAME}"; then
  ## generate working link on working dir
  func_gen_working_dir_link "${WORKING_DIR_NAME}" "${WORKING_LINK_DIR}"
else
  func_fatal_error "- directory ${WORKING_DIR_NAME} does not exist !!! STOP !!!"
fi

## -------------------------------------------------------------------------- ##
## Pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
