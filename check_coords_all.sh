#!/bin/bash
# uses check_coords.py to check coordinates for all of Liber

die() { echo "$@" 1>&2 ; exit 1; }

[[ ! $# -eq 1 || $1 = -h ]] && die "Usage: ./check_coords_all.sh path_to_Liber"

FOLDERS=$1/*
for f in $FOLDERS
do
	python check_coords.py $f/$(basename $f)_corr.mei $f/$(basename $f)_corr_old.mei
	python check_coords.py $f/$(basename $f)_uncorr.mei $f/$(basename $f)_uncorr_old.mei
done