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
    echo "usage: run-model.sh [-options] [<model>]"
    echo "where options include:"
    echo "  -h              this help message"
    echo "  -c <modelname>  name of the model to compile and then run"
    echo "  <modelname>     name of the model to run"
    echo " "
    exit 1
fi

# Check if an argument is provided, if not exit with an error message
if [ -z "$1" ]; then
    echo "No model file specified"
    exit 1
fi

# Check if the first argument is -c and there is no model file specified
if [ "$1" = "-c" ] && [ -z "$2" ]; then
    echo "No model file specified"
    exit 1
fi

# Check if a second argument is provided, if not set the model name from $1
# If a second argument is provided, set the model name from $2
# If the first argument is -c, compile the model and set the model name from $2
# If the first argument is not -c, set the model name from $1
# Run the specified brahms model.
if [ -z "$2" ]; then
    #set the model name from $1 to the filename without the extension
    filename=$(basename -- "$1")
    modelName="${filename%.*}"
else #compile the model if -c is specified
    #first set the model name from $2 to the filename without the extension
    filename=$(basename -- "$2")
    modelName="${filename%.*}"
    if [ "$1" = "-c" ]; then
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
        # Compiles the specified brahms model in $2.
        $BRAHMS_HOME/bin/bc -lp $BRAHMS_HOME/Models/lib -source . -d ./build -bar ./target/${modelName}.bar -dtd $BRAHMS_HOME/DTD -cp $BRAHMS_HOME/Agents src/$modelName.b
    fi
fi

# Run the specified brahms model.
echo " "
echo "Running model $modelName"
echo " "
# Check if the model xml file exists, if not exit with an error message
if [ ! -f "./build/${modelName}.bcc" ]; then
    echo "Model file ./build/${modelName}.bcc does not exist"
    #exit 1
    # Check if the model bar file exists, if not exit with an error message
    if [ ! -f "./target/${modelName}.bar" ]; then
        echo "Model file ./target/${modelName}.bar does not exist"
        exit 1
    fi
fi

# Check if the databases directory exists, if not create it
if [ ! -d "./databases" ]; then
    mkdir ./databases
fi

# Run the specified brahms model.
$BRAHMS_HOME/bin/bvm -cf $BRAHMS_HOME/config/vm.cfg -ui $modelName