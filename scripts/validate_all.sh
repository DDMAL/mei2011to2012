#!/bin/bash
# validates all mei files in Liber

die() { echo "$@" 1>&2 ; exit 1; }

[[ ! $# -eq 2 || $1 = -h ]] && die "Usage: ./process.sh schema.rng path_to_Liber"

FOLDERS=$2/*
for f in $FOLDERS
do
	xmllint --noout --relaxng $1 $f/$(basename $f)_corr.mei
	xmllint --noout --relaxng $1 $f/$(basename $f)_uncorr.mei
done