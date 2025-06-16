#!/bin/bash

## ########################################################################## ##
##
## Build BusyBox - generate tar
##
## ########################################################################## ##
## includes:
. ./init

## defines:
CALLEE="$1"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_pack_busybox(){ # src_path="$1" dest_path="$2" comp_type="$3"
  local src_path dest_path tar_file_name
  src_path="$1"; dest_path="$2"; comp_type="$3"

  ## remove destination directory if present
  [ -d "${dest_path}" ] && sudo rm -rf "${dest_path}"

  ## copy source path to destination path
  sudo cp -rf "${src_path}" "${dest_path}"

  ## adapt destination
  sudo rm -f "${dest_path}"/linuxrc
  "${dest_path}"/bin/busybox | sudo tee "${dest_path}"/bin/busybox.txt
  file "${dest_path}"/bin/busybox | sudo tee "${dest_path}"/bin/busybox-filetype.txt
  uname -a | sudo tee "${dest_path}"/bin/busybox-build-env.txt
  tree "${dest_path}" | sudo tee "${dest_path}"/bin/busybox-tree.txt

  ## create archiv
  tar_file_name="$(basename "${dest_path}").tar"
  [ -d "${tar_file_name}.${comp_type}" ] \
    && sudo rm -f "${tar_file_name}.${comp_type}"

  func_tar_create_archiv "${dest_path}" "${tar_file_name}" "${comp_type}"
  [ -d "${dest_path}" ] && sudo rm -rf "${dest_path}"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## set and mkdir DESTINATION="obj/busybox-x86-v${version}"
func_set_and_mk_DESTINATION "${GIT_REPOSITORY_NAME}"

## generate a busybox tar archive
func_pack_busybox "${DESTINATION}/_install" "busybox-install" "${TAR_COMPRESSION}"

## -------------------------------------------------------------------------- ##
## pause:
func_pause

## ########################################################################## ##
exit 0
