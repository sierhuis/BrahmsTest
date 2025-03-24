#!/bin/bash

# Using BRAHMS_HOME directly for consistency
# Check if BRAHMS_HOME is set, if not exit with an error message
if [ -z "$BRAHMS_HOME" ]; then
    echo "BRAHMS_HOME is not set"
    exit 1
fi

# Check if the first argument is -h and there is no model file specified
if [ "$1" = "-h" ] && [ -z "$2" ]; then
    echo " "
    echo "usage: build-model.sh [-options] [<model>]"
    echo "where options include:"
    echo "  -h              this help message"
    echo "  <modelname>     name of the model to compile"
    echo " "
    exit 1
fi

# Check if an argument is provided, if not exit with an error message
if [ -z "$1" ]; then
    echo "No model file specified"
    exit 1
fi

filename=$(basename -- "$1")
modelName="${filename%.*}"

# Compiles the specified brahms model.
echo " "
echo "Compiling model $modelName"
echo " "

# Check if the build and target directories exist, if not create them
if [ ! -d "./build" ]; then
    mkdir ./build
fi

# Check if the target directory exists, if not create it
if [ ! -d "./target" ]; then
    mkdir ./target
fi

# Check if the source directory exists, exit with an error message
if [ ! -d "./src" ]; then
    echo " "
    echo "Source directory "./src" does not exist"
    echo " "
    exit 1
fi

# Compiles the specified brahms model in $2.
$BRAHMS_HOME/bin/bc -lp $BRAHMS_HOME/Models/lib -source . -d ./build -bar ./target/${modelName}.bar -dtd $BRAHMS_HOME/DTD -cp $BRAHMS_HOME/Agents src/$modelName.b
#$BRAHMS_HOME/bin/bc -lp $BRAHMS_HOME/Models/lib -source . -d ./build -bar ./target/${fileBasenameNoExtension}.bar -dtd $BRAHMS_HOME/DTD -cp $BRAHMS_HOME/Agents $1
exit