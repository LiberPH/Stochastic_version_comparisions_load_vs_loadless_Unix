#!/usr/bin/env bash

##################################################
# Function to handle errors
##################################################
yaValio() {
    # Send the error message to STDERR, then exit
    echo >&2 "$@"
    exit 1
}
##################################################
# Check for the right number of parameters
# If the number of parameters is greater than 3...
[ "$#" -eq 4 ] || yaValio "
`basename $0` requieres 4 parameters, but received $#

Usage:
`basename $0` outputDirectory bnglFile1 origbnglfile workFileName TAU
"
##################################################
# Report initial configuration of the script and set variables
echo "`basename $0` started. OutputDirectory is $1, bnglFile is $2, bnglFile2 is $3 workFileNameis $4"
WORKINGDIR=$1
BNGLFILE=$2
ORIG=$3
WORKFILENAME=$4
WORKFILE="$WORKFILENAME".bngl

##################################################
# Create a directory and move into it.

echo Creating directory "$WORKINGDIR"...
mkdir $WORKINGDIR
echo "cd'ing into $WORKINGDIR"...
cd $WORKINGDIR
echo "Current directory is `pwd`..."

##################################################
# Copy the bngl file inside the just created directory


TAU=10
init=0

~/Documentos/Stoch_new/StochasticParams.sh "$WORKINGDIR" $BNGLFILE "$ORIG" "$WORKFILENAME" "$TAU" "$init"> "$WORKFILENAME".txt

cd ..

TAU=43
init=0

~/Documentos/Stoch_new/StochasticParams.sh "$WORKINGDIR" $BNGLFILE "$ORIG" "$WORKFILENAME" "$TAU" "$init"> "$WORKFILENAME".txt 

cd ..

TAU=120
init=0

~/Documentos/Stoch_new/StochasticParams.sh "$WORKINGDIR" $BNGLFILE "$ORIG" "$WORKFILENAME" "$TAU" "$init"> "$WORKFILENAME".txt

cd ..

TAU=250
init=0

~/Documentos/Stoch_new/StochasticParams.sh "$WORKINGDIR" $BNGLFILE "$ORIG" "$WORKFILENAME" "$TAU" "$init"> "$WORKFILENAME".txt

cd ..