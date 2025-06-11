#! /bin/bash

## ########################################################################## ##
##
## build a working-dir
##
## ########################################################################## ##
## includes:
source ./init

## -------------------------------------------------------------------------- ##
## MAIN
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## check on WORKING_DIR_NAME
## - the working directory is only created if no version of it exists yet
if func_check_dir "${WORKING_DIR_NAME}"; then
  func_fatal_error "- directory ${WORKING_DIR_NAME} does exist !!! STOP !!!"
else
  ## create a working directory
  mkdir -p "${WORKING_DIR_NAME}/main"
  func_tar_extract_archiv "../archives/${INITRD_BASE}" \
    "${WORKING_DIR_NAME}" "${TAR_COMPRESSION}"
  func_tar_extract_archiv "../archives/${INITRD_BUSYBOX}" \
    "${WORKING_DIR_NAME}/main" "${TAR_COMPRESSION}"
  func_tar_extract_archiv "../archives/${INITRD_INIT}" \
    "${WORKING_DIR_NAME}" "${TAR_COMPRESSION}"
fi

## -------------------------------------------------------------------------- ##
## Pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
