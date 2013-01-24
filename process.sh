#!/bin/bash
# Applies an xsl to all documents in a folder and outputs to another folder
# To run this script, Saxon has to be installed using the instructions from
# http://www.wwp.brown.edu/outreach/seminars/_current/handouts/roma_CLI_MacOS_X.html#saxon

die() { echo "$@" 1>&2 ; exit 1; }

[[ ! $# -eq 3 || $1 = -h ]] && die "Usage: ./process.sh stylesheet.xsl input_folder output_folder"
[[ -e $1 ]] || die "Cannot find the stylesheet specified"
[[ -e $2 ]] || die "Cannot find the input folder specified"
mkdir -p $3

FILES=$2/*
for f in $FILES
do
	saxon -s:$f -xsl:$1 -o:$3/$(basename $f)
done