#!/bin/bash
# Andrea Blasco <ablasco@fas.harvard.edu>
#***********************************************#
E_BADDIR=85 # Error bad directory
E_BADFILE=86 # Error bad file

input_file=$1

if [ ! -f "$input_file" ] # Check input file
then
	echo "$input_file file not found!"
	exit $E_BADFILE
fi	

#***********************************************#
bib_file="$HOME/Library/Application Support/BibDesk/library.bib"
config_dir=${3:-Config}
output_dir=${2:-Paper}
#***********************************************#

if [ ! -d "$output_dir" ] || [ ! -d "$config_dir" ] # Check
then
	echo "$1 or $2 is not a directory."
	exit $E_BADDIR
fi


# --------------------------------------------------------- #
# copy_data ()                                         		#
# Copy all files in designated directory.                	#
# Parameters: $target_directory, $config_dir                #
# Returns: 0 on success, $E_BADDIR if something went wrong. #
# --------------------------------------------------------- #
copy_data () {
	cp -v "$bib_file" "$1"
	cp -v .RData "$1"
	cp -vR "$2"/* "$1"
	cp -v *.R *.Rmd "$1"
	return 0
}
clean_dir () {
	rm -r "$1"/*
	return 0
}

# Compile report
# clean_dir $output_dir
copy_data $output_dir $config_dir
cd $output_dir
Rscript -e "rmarkdown::render('$input_file')"
mkdir Code && mv *.Rmd Code

# Open document
open -a Skim ${input_file%.*}.pdf

exit 0


#***********************************************#
if [ "$1" == "--data" ]; then
	mv .RData $data_dir/$now.RData
	Rscript -e "source('prep_data.R')"
	exit $?
fi

if [ "$1" == "--notes" ]; then
	clean_dir $notes_dir
	copy_data $notes_dir $config_dir
	cd $notes_dir && compile report_notes.Rmd
	exit $?
fi


if [ "$1" == "--paper" ]; then
	clean_dir $paper_dir
	copy_data  $paper_dir $config_dir
	cd $notes_dir && compile report_notes.Rmd
	exit $?
fi

if [ "$1" == "--profiles" ]; then
	Rscript prep_data_profiles.R > Data/Profiles/qualtrics_advformat_profiles.txt
	exit 0
fi


if [ "$1" == "--slides" ]; then
	input=report_slides.Rmd
	cp .RData $input func.R Slides/ 
	cd Slides && crmd $input
	exit
fi

if [ "$1" == "--survey" ]; then
	compile report_survey.Rmd $notes_dir
	exit 0
fi



# echo "Copy data..."
# cp $data $output_dir/.RData 
# cp timing.csv $output_dir/
# echo "Copy source R files..."
# cp *.Rmd $output_dir/
# echo "Copy config, templates, headers, footers..."
# cp Templates/* $output_dir/Templates
# cp Config/_output.yml $output_dir/
# echo "Compile report..."
# cd $output_dir && crmd report.Rmd > report.Rout 2> report.err
# echo "Clean up..."
# mv .RData *.Rmd Code/ 
# echo "Done!"





