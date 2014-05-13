#!/usr/bin/env bash

############################################
#Stochsimulations.sh
#Script to run 1000 stochastic simulations of the control and the dynamic with loads.
#These simulations will be used to calculate the dynamics density and its properties (mean, sd, etc...).
#
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
#y=-5
#z=0
#a=-5
#b=0
#n=0


#sed -i '' "s/koffR koff\*2\^$a/koffR koff/g" $WORKFILE
#sed -i '' "s/koffR koff\*2\^$a/koffR koff/g" control.bngl

#sed -i '' "s/konR .*/konR kon/g" $WORKFILE
#sed -i '' "s/konR .*/konR kon/g" control.bngl

for ll in {1..1000}
	do
		$RUNBNGL $WORKFILE                    
        $RUNBNGL control.bngl
		cp control.gdat control_"$ll".gdat   
        cp "$WORKFILENAME".gdat "$WORKFILENAME"_"$TAU"_"$KON"_"$KOFF"_"$ll".gdat
		Rscript $RUNR "$WORKFILENAME".gdat control.gdat output.txt
		Rscript $RUNR2 "$WORKFILENAME".gdat control.gdat output2.txt
		#Rscript $RUNR control.gdat mastercontrol.gdat output3.txt
		cat output.txt >> OUTPUT.txt
		echo "" >> OUTPUT.txt
		cat output2.txt >> OUTPUT2.txt
		echo "" >> OUTPUT2.txt
		#cat output3.txt >> OUTPUT3.txt
		#echo "" >> OUTPUT3.txt                   		
	done

Rscript $RUNR3 "$WORKFILENAME"_"$TAU"_"$KON"_"$KOFF" 
#Rscript $RUNR4 OUTPUT.txt OUTPUT2.txt OUTPUT3.txt




