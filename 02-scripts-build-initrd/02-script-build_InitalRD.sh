#! /bin/bash

## ########################################################################## ##
##
## build new Inital Ram Disk
##
## ########################################################################## ##
## includes
source ./init

## -------------------------------------------------------------------------- ##
## FUNCTIONS
## -------------------------------------------------------------------------- ##
func_process(){ # input_path="$1"; output_path="$2"; file_name="$3"
  local output_path input_path file_name
  input_path="$1"; output_path=$(realpath "$2"); file_name="$3"

  local current_path archive_typ output_file log_file info array file
  current_path="$PWD"
  archive_typ="gz"; output_file="${file_name}.${archive_typ}"
  log_file="${file_name}.sha256"

  info=$(realpath ./"${input_path}"); info="${info//*build-initrd\//}"

  ## generate output directory if neccessary
  [ -d "${output_path}" ] || mkdir -p "${output_path}"

  ## jump in resp. directory and build cpio file and pack with gzip
  cd "${input_path}" || exit 1
  { sudo find . | sudo cpio -oH newc | sudo gzip -9; } > "${output_path}/${output_file}"

  ## jump in resp. directory and generate info file
  cd "${output_path}" || exit 1
  readarray -t array < <(find ./ -name "*.${archive_typ}")
  {
    echo "# Inital Ram Disk versions: ${info}"
    for file in "${array[@]}"; do
      sha256sum "${file}"
    done
  } > "${log_file}"

  ## jump back to further path
  cd "${current_path}" || exit 1
}

## -------------------------------------------------------------------------- ##
## MAIN
## -------------------------------------------------------------------------- ##
## change to build directory
func_change_to_dir "${BUILD_DIR}"

## check if process is possible
## - a version of the working directory exists yet
if func_check_dir "${WORKING_LINK_DIR}"; then
  func_build_dir "${SAVE_DIR}"
  func_process "${WORKING_LINK_DIR}/${EXTRACT_DIR}/" "${SAVE_DIR}" "${RD_FILE_TYP}"
else
  func_fatal_error "- link ${WORKING_LINK_DIR} does not exist !!! STOP !!!"
fi


## -------------------------------------------------------------------------- ##
## Pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
