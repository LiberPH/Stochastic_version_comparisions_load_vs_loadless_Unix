#!/usr/bin/env bash

############################################
#Stochsimulations_changing_kon_and_koff.sh
#Script to run 1000 stochastic simulations of the control and the dynamic with loads.
#These simulations will be used to calculate the dynamics density and its properties (mean, sd, etc...).
#Similar to Stochsimulations.sh, but changing koff2 (koffR) and Kd2(KdR) to compare the influence of those parameters
#in load induced retroactivity.
#############################################
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
# If the number of parameters is greater than 8...
[ "$#" -eq 8 ] || yaValio "
`basename $0` requieres 8 parameters, but received $#

Usage:
`basename $0` outputDirectory bnglFile1 origbnglfile workFileName TAU
"
##################################################
# Report initial configuration of the script and set variables
echo "`basename $0` started. OutputDirectory is $1, bnglFile is $2, bnglFile2 is $3, workFileName is $4, TAU is $5 and init is $6, KON is $7 and KOFF is $8"
WORKINGDIR=$1
BNGLFILE=$2
ORIG=$3
WORKFILENAME=$4
TAU=5
init=6
KON=7
KOFF=8
WORKFILE=$WORKFILENAME.bngl

##################################################

##################################################
WORKINGDIR=$1
BNGLFILE=$2
ORIG=$3
WORKFILENAME=$4
TAU=$5 
KON=$6
KOFF=$7
init=$8
WORKFILE="$WORKFILENAME".bngl
#ORIG=~/200513/5_nuc_onoff_cd_mol.bngl
RUNBNGL="perl /opt/RuleBender-2.0.382-lin64/BioNetGen-2.2.5/BNG2.pl"
RUNR=~/canberra.R #Get Canberra distance
RUNR2=~/normalize_kon_koff.R #Get normalized Canberra's distance
RUNR3=~/Documents/Stoch_new/Plots_and_analysis.R #Parse results for plots
#RUN4=~/Documents/Stochastic_new/Plots_and_analysis_diffs.R
##################################################
# Create a directory and move into it.

##################################################
# Copy the bngl files inside the just created directory

cp $ORIG mastercontrol.bngl
cp $BNGLFILE $WORKFILE
cp $ORIG control.bngl


##################################################

echo "

About to run BioNetGen on several files.
This is going to take a while. Go grab some popcorn or get some coffee.
...

"


y=-5
z=0
a=-5
b=0
n=0

$RUNBNGL mastercontrol.bngl


for ((b=-5; b<=5 ; b++));
    do #Changing koffR
        sed -i '' "s/koffR koff\*2\^$a/koffR koff\*2\^$b/g" $WORKFILE
        sed -i '' "s/koffR koff\*2\^$a/koffR koff\*2\^$b/g" control.bngl
        for ((z=-5; z<=5 ; z++));
            do #Changing kdR
                sed -i '' "s/kdR kd\*2\^$y/kdR kd\*2\^$z/g" $WORKFILE
                sed -i '' "s/kdR kd\*2\^$y/kdR kd\*2\^$z/g" control.bngl

                for ll in {1..1000}
                    do
                        $RUNBNGL $WORKFILE
                        $RUNBNGL control.bngl
                        cp control.gdat control_"$ll".gdat
                        cp "$WORKFILENAME".gdat "$WORKFILENAME"_"$TAU"_"$KON"_"$KOFF"_"$b"_"$z"_"$ll".gdat
                        Rscript $RUNR "$WORKFILENAME".gdat control.gdat output_"$b"_"$z".txt
                        Rscript $RUNR2 "$WORKFILENAME".gdat control.gdat output2_"$b"_"$z".txt
                        #Rscript $RUNR control.gdat mastercontrol.gdat output3.txt
                        cat output_"$b"_"$z".txt >> OUTPUT_"$b"_"$z".txt
                        echo "" >> OUTPUT_"$b"_"$z".txt
                        cat output2_"$b"_"$z".txt >> OUTPUT2_"$b"_"$z".txt
                        echo "" >> OUTPUT2_"$b"_"$z".txt
                    done
            done
    done

Rscript $RUNR3 "$WORKFILENAME"_"$TAU"_"$KON"_"$KOFF" 
#Rscript $RUNR4 OUTPUT.txt OUTPUT2.txt OUTPUT3.txt




