#! /bin/bash

## ########################################################################## ##
##
## build a working-dir
##
## ########################################################################## ##
## includes:
source ./init

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## get all archives
func_get_all_archives(){ # source_dir="$1"; dest_dir="$2"
  local source_dir dest_dir array file
  source_dir="$1"; dest_dir="$2"

  ## create a working directory
  mkdir -p "${dest_dir}/main"

  ## check on tar files
  readarray -t array < <(find "${source_dir}" -name "*.tar*")
  for file in "${array[@]}"
  do
    echo "file: ${file}"
    ## note: strip-components=1 removes first directory level
    cmd="sudo tar -xf ${file} --strip-components=1 -C ${dest_dir}"
    #echo "${cmd}"
    eval "${cmd}"
  done
  ## return if one or more tar files exist
  [ "${#array[@]}" -eq 0 ] || return 0

  ## check on initrd files (gzip[cpio])
  file="${source_dir}/initrd.gz"
  [ -f "${file}" ] || return 1
  echo "file: ${file}"
  cmd="sudo unmkinitramfs ${file} ${dest_dir}/main"
  #echo "${cmd}"
  eval "${cmd}"
}

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
  func_get_all_archives "../archives" "${WORKING_DIR_NAME}"
fi

## -------------------------------------------------------------------------- ##
## Pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
