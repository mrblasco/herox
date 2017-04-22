#!/bin/bash
output_dir=Paper
notes_dir=Paper_notes
slides_dir=Slides
now=`date +%b%d`
report_file=report.Rmd

function compile () {
	cp -v *.RData "$2"
	cp -vR Config/ "$2"
	cp -v "$1" "$2"
	cd "$2" && crmd "$1"
}


# Prepare data
if [ "$1" == "--data" ]; then
	mv .RData $now.RData
	Rscript -e "source('prep_data.R')"
	exit
fi

if [ "$1" == "--slides" ]; then
	input=report_slides.Rmd
	cp .RData $input func.R Slides/ 
	cd Slides && crmd $input
	exit
fi

if [ "$1" == "--notes" ]; then
	compile report_notes.Rmd $notes_dir
	exit 0
fi

if [ "$1" == "--survey" ]; then
	compile report_survey.Rmd $notes_dir
	exit 0
fi

if [ "$1" == "--profiles" ]; then
	compile report_profiles.Rmd $notes_dir
	exit 0
fi

if [ "$1" == "--paper" ]; then
	cp ~/Library/Application\ Support/BibDesk/library.bib $output_dir/
	cp -vR Config/ $output_dir
	cp *.Rmd *.R .RData $output_dir
	cd $output_dir && crmd $report_file > report.Rout 2> report.Rerr
	exit
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





