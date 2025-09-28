#! /bin/bash

## ########################################################################## ##
##
## write back the working directory to archive directory
##
## ########################################################################## ##
## includes
source ./init

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_process(){

  ## generate part of directory: INITRD_INIT
  func_remove_archiv_file "${INITRD_INIT}.tar" "${TAR_COMPRESSION}"
  func_copy_dir "${WORKING_DIR_NAME}" "${INITRD_INIT}"
  func_archiv_handling "${INITRD_INIT}" "2" "d"

  ## generate part of directory: INITRD_BASE
  func_remove_archiv_file "${INITRD_BASE}.tar" "${TAR_COMPRESSION}"
  func_copy_dir "${WORKING_DIR_NAME}" "${INITRD_BASE}"
  func_remove_list_of_dirs "${INITRD_BASE}/${EXTRACT_DIR}" \
    "bin sbin usr/bin usr/sbin"
  func_archiv_handling "${INITRD_BASE}" "2" "f"

  ## generate part of directory: INITRD_BUSYBOX
  func_remove_archiv_file "${INITRD_BUSYBOX}.tar" "${TAR_COMPRESSION}"
  func_copy_dir "${WORKING_DIR_NAME}/${EXTRACT_DIR}" "${INITRD_BUSYBOX}"
  func_remove_list_of_dirs "${INITRD_BUSYBOX}" \
    "dev etc info mnt mnt-system mnt-user modules proc ramdisk sys tmp UNIONFS"
  func_archiv_handling "${INITRD_BUSYBOX}" "1" "f"
}

func_remove_archiv_file(){ # tar_file_name="$1" comp_type="$2"
  local comp_type tar_file_name
  comp_type="$2"
  tar_file_name="$1"
  [ -n "${comp_type}" ] && tar_file_name="$1.${comp_type}"
  func_remove_file "${tar_file_name}"
}

func_remove_list_of_dirs(){ # output="$1" list="$2"
  local output list element
  output="$1"; list="$2"

  for element in ${list}; do
    func_remove_dir "${output}/${element}"
  done
}

func_archiv_handling(){ # output="$1" depth="$2" type="$3"
  local output depth type
  output="$1"; depth="$2"; type="$3"

  func_remove_file_list "${output}" "${depth}" "${type}"
  func_tar_create_archiv "${output}" "${output}.tar" "${TAR_COMPRESSION}"
  func_remove_dir "${output}"
}

func_remove_file_list(){ # output="$1" depth="$2" type="$3"
  local output depth type element file_list
  output="$1"; depth="$2"; type="$3"

  file_list=$(find "${output}" -mindepth "${depth}" -maxdepth "${depth}" \
    -type "${type}" -printf "%p ")
  for element in ${file_list} ; do
    if [ "${type}" = "d" ]; then
      func_remove_dir "${element}"
    else
      sudo rm -f "${element}"
    fi
  done
}

## -------------------------------------------------------------------------- ##
## MAIN
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## check if process is possible
## - a version of the working directory exists yet
if func_check_dir "${WORKING_DIR_NAME}"; then
  func_process
else
  func_fatal_error "- directory ${WORKING_DIR_NAME} does not exist !!! STOP !!!"
fi

## -------------------------------------------------------------------------- ##
## Pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
