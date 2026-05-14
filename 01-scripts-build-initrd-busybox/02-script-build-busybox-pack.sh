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
func_pack_busybox(){ # src_path="$1" output_path="$2" comp_type="$3"
  local src_path dest_path tar_file_name
  src_path="$1"; output_path="$2"; comp_type="$3"

  ## remove destination directory if present
  [ -d "${output_path}" ] && sudo rm -rf "${output_path}"

  ## adapt dest_path
  dest_path="${output_path}/main"
  #dest_path="${output_path}"
  [ -d "${dest_path}" ] || sudo mkdir -p "${dest_path}"

  ## copy source path to destination path
  sudo cp -rf "${src_path}/." "${dest_path}/"

  ## adapt destination
  sudo rm -f "${dest_path}"/linuxrc
  "${dest_path}"/bin/busybox | sudo tee "${dest_path}"/bin/busybox.txt
  file "${dest_path}"/bin/busybox | sudo tee "${dest_path}"/bin/busybox-filetype.txt
  uname -a | sudo tee "${dest_path}"/bin/busybox-build-env.txt
  tree "${dest_path}" | sudo tee "${dest_path}"/bin/busybox-tree.txt

  ## create archiv
  tar_file_name="$(basename "${output_path}").tar"
  [ -d "${tar_file_name}.${comp_type}" ] \
    && sudo rm -f "${tar_file_name}.${comp_type}"
  func_tar_create_archiv "${dest_path}" "${tar_file_name}" "${comp_type}"

  ## remove temp directory
  [ -d "${output_path}" ] && sudo rm -rf "${output_path}"
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
