#!/bin/bash
set -ex

function install_tamods_package() {
  tmp_file=$(mktemp) # tmp file for download
  tmp_dir=$(mktemp -d) # tmp dir for extracted files

  wget -q -O $tmp_file $1
  unzip -q $tmp_file -d $tmp_dir
  cp -r $tmp_dir/\!TRIBESDIR/* "Tribes"

  rm $tmp_file
  rm -rf $tmp_dir
}

install_tamods_package "https://tamods-update.s3-ap-southeast-2.amazonaws.com/packages/master-refshadercache.zip"
install_tamods_package "https://tamods-update.s3-ap-southeast-2.amazonaws.com/packages/custom-maps-asset-pack.zip"
install_tamods_package "https://tamods-update.s3-ap-southeast-2.amazonaws.com/packages/dodge-map-pack.zip"