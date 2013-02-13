MEI2011to2012
=============

About
-----
This XSLT was written to transform the Liber Usualis from MEI v.2011 to v.2012. The major changes include

* migration of <layout> to <layouts>
* using <laidOutElement> instead of <zone> to point to elements (excludes lyrics)
* moving sections onto one staff

Minor changes were also made for validation purposes.

This repository also contains scripts to aid the transformation and validation process. The scripts folder contains the following scripts that process all of Liber when run

* process_liber.sh - applies the XSLT
* check_coords_all.sh - checks for discrepancies between transformed and untransformed versions
* validate_all.sh - validates files against an rng schema
