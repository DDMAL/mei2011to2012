#!/bin/bash
# Applies an xsl to all documents in a folder and outputs to another folder.
# To run this script, Saxon has to be installed using the instructions from
# http://www.wwp.brown.edu/outreach/seminars/_current/handouts/roma_CLI_MacOS_X.html#saxon
# Processes the Liber Usualis Final Output using existing file structure.
# Moves old mei files to xxxx_(un)corr.mei to xxxx_(un)corr_old.mei and ouputs transformed
# mei file to xxxx_(un)corr.mei.

die() { echo "$@" 1>&2 ; exit 1; }

[[ ! $# -eq 2 || $1 = -h ]] && die "Usage: ./process.sh stylesheet.xsl path_to_Liber"
[[ -e $1 ]] || die "Cannot find the stylesheet specified"
[[ -e $2 ]] || die "Cannot find path_to_Liber"

FOLDERS=$2/*
for f in $FOLDERS
do
	mv $f/$(basename $f)_corr.mei $f/$(basename $f)_corr_old.mei
	saxon -s:$f/$(basename $f)_corr_old.mei -xsl:$1 -o:$f/$(basename $f)_corr.mei
	echo "Processed file: $(basename $f)_corr.mei"
	mv $f/$(basename $f)_uncorr.mei $f/$(basename $f)_uncorr_old.mei
	saxon -s:$f/$(basename $f)_uncorr_old.mei -xsl:$1 -o:$f/$(basename $f)_uncorr.mei
	echo "Processed file: $(basename $f)_uncorr.mei"
done