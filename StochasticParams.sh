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
# If the number of parameters is greater than 6...
[ "$#" -eq 6 ] || yaValio "
`basename $0` requieres 6 parameters, but received $#

Usage:
`basename $0` outputDirectory bnglFile1 origbnglfile workFileName TAU
"
##################################################
# Report initial configuration of the script and set variables
echo "`basename $0` started. OutputDirectory is $1, bnglFile is $2, bnglFile2 is $3, workFileName is $4, TAU is $5 and init is $6"

##################################################
WORKINGDIR=$1
BNGLFILE=$2
ORIG=$3
WORKFILENAME=$4
TAU=$5 
WORKFILE="$WORKFILENAME".bngl
#ORIG=~/200513/5_nuc_onoff_cd_mol.bngl
RUNBNGL="perl /opt/RuleBender-2.0.271-lin64/BioNetGen-2.2.2/BNG2.pl"
RUNR=~/canberra.R
RUNR2=~/normalize_kon_koff.R
##################################################
# Create a directory and move into it.

echo Creating directory "$WORKINGDIR"_"$TAU"...
mkdir "$WORKINGDIR"_"$TAU"
echo "cd'ing into "$WORKINGDIR"_"$TAU""...
cd "$WORKINGDIR"_"$TAU"
echo Current directory is `pwd`...

##################################################
# Copy the bngl files inside the just created directory
echo "El archivo original está en $ORIG"

cp $ORIG mastercontrol.bngl
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl


##################################################
mkdir "$WORKINGDIR"_params_e-9_e-11
cd "$WORKINGDIR"_params_e-9_e-11
cp $ORIG mastercontrol.bngl
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl

sed -i '' "s/tau 120/tau $TAU/g" control.bngl
sed -i '' "s/tau 120/tau $TAU/g" mastercontrol.bngl
sed -i '' "s/tau 120/tau $TAU/g" $WORKFILE

sed -i '' "s/As 0/As $init/g" control.bngl
sed -i '' "s/As 0/As $init/g" mastercontrol.bngl
sed -i '' "s/As 0/As $init/g" $WORKFILE


echo "
About to run BioNetGen on several files.
This is going to take a while. Go grab some popcorn or get some coffee.
...

"

KON=1e-9
KOFF=1e-11
cosa=`pwd`

~/Documentos/Stoch_new/Stochsimulations.sh "$WORKINGDIR" "$cosa"/"$WORKFILE" "$cosa"/control.bngl "$WORKFILENAME" "$TAU" "$KON" "$KOFF" "$init"> "$WORKFILENAME".txt

cd ..

#################################################

mkdir "$WORKINGDIR"_params_on_0.000409_off_3e-3
cd "$WORKINGDIR"_params_on_0.000409_off_3e-3
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl
cp $ORIG mastercontrol.bngl
sed -i '' "s/tau 120/tau $TAU/g" control.bngl
sed -i '' "s/tau 120/tau $TAU/g" $WORKFILE
sed -i '' "s/tau 120/tau $TAU/g" mastercontrol.bngl

echo "

About to run BioNetGen on several files.
This is going to take a while. Go grab some popcorn or get some coffee.
...
"

KON=0.000409
KOFF=3e-3
cosa=`pwd`

~/Documentos/Stoch_new/Stochsimulations.sh "$WORKINGDIR" "$cosa/$WORKFILE" "$cosa/control.bngl" "$WORKFILENAME" "$TAU" "$KON" "$KOFF" "$init"> "$WORKFILENAME".txt
             
cd ..

#################################################

mkdir "$WORKINGDIR"_params_on_0.0002_off_4e-3
cd "$WORKINGDIR"_params_on_0.0002_off_4e-3
cp $ORIG mastercontrol.bngl
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl
sed -i '' "s/tau 120/tau $TAU/g" control.bngl
sed -i '' "s/tau 120/tau $TAU/g" $WORKFILE
sed -i '' "s/tau 120/tau $TAU/g" mastercontrol.bngl

echo "

About to run BioNetGen on several files.
This is going to take a while. Go grab some popcorn or get some coffee.
...

"
KON=0.0002
KOFF=4e-3
cosa=`pwd`

~/Documentos/Stoch_new/Stochsimulations.sh "$WORKINGDIR" "$cosa"/"$WORKFILE" "$cosa"/control.bngl "$WORKFILENAME" "$TAU" "$KON" "$KOFF" "$init"> "$WORKFILENAME".txt


cd ..

#######################################################
mkdir "$WORKINGDIR"_params_on_0.0225_off_0.045
cd "$WORKINGDIR"_params_on_0.0225_off_0.045
cp $ORIG mastercontrol.bngl
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl
sed -i '' "s/tau 120/tau $TAU/g" control.bngl
sed -i '' "s/tau 120/tau $TAU/g" $WORKFILE
sed -i '' "s/tau 120/tau $TAU/g" mastercontrol.bngl

echo "

About to run BioNetGen on several files.
This is going to take a while. Go grab some popcorn or get some coffee.
...

"
KON=0.0225
KOFF=0.045
cosa=`pwd`

~/Documentos/Stoch_new/Stochsimulations.sh "$WORKINGDIR" "$cosa"/"$WORKFILE" "$cosa"/control.bngl "$WORKFILENAME" "$TAU" "$KON" "$KOFF" "$init"> "$WORKFILENAME".txt

cd ..

########################################################
mkdir "$WORKINGDIR"_params_on_0.0065_off_0.13
cd "$WORKINGDIR"_params_on_0.0065_off_0.13
cp $ORIG mastercontrol.bngl
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl
sed -i '' "s/tau 120/tau $TAU/g" control.bngl
sed -i '' "s/tau 120/tau $TAU/g" $WORKFILE
sed -i '' "s/tau 120/tau $TAU/g" mastercontrol.bngl

echo "

About to run BioNetGen on several files.
This is going to take a while. Go grab some popcorn or get some coffee.
...

"
KON=0.0065
KOFF=0.13
cosa=`pwd`

~/Documentos/Stoch_new/Stochsimulations.sh "$WORKINGDIR" "$cosa"/"$WORKFILE" "$cosa"/control.bngl "$WORKFILENAME" "$TAU" "$KON" "$KOFF" "$init"> "$WORKFILENAME".txt

cd ..


cd ..

