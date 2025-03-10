#!/bin/sh
#
filename=$(basename -- "$1")
fileBasenameNoExtension="${filename%.*}"
# Compiles the specified brahms model.
$BRAHMS_HOME/bin/bc -lp $BRAHMS_HOME/Models/lib -source . -d ./build -bar ./target/${fileBasenameNoExtension}.bar -dtd $BRAHMS_HOME/DTD -cp $BRAHMS_HOME/Agents $1
exit