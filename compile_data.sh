#!/bin/bash
# Andrea Blasco <ablasco@fas.harvard.edu>
#***********************************************#
E_BADDIR=85 # Error bad directory
E_BADFILE=86 # Error bad file

input_file=prep_data.R

if [ ! -f "$input_file" ] # Check input file
then
	echo "$input_file file not found!"
	exit $E_BADFILE
fi	

Rscript $input_file
Rscript prep_data_profiles.R > Data/Profiles/qualtrics_advformat_profiles.txt

exit 0
