#!/bin/bash

filename=$(basename -- "$1")
fileBasenameNoExtension="${filename%.*}"
# Used to refer to the correct .properties file

  ${BRAHMS_HOME}/bin/bvm -cf config/osx-vm.cfg -ui $fileBasenameNoExtension

