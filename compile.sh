#!/bin/bash
output_dir=Paper
notes_dir=Paper_notes
slides_dir=Slides
now=`date +%b%d`
report_file=report.Rmd
notes_file=report_notes.Rmd
slides_file=report_slides.Rmd

# Prepare data
# mv .RData $now.RData
# Rscript -e "source('report_prep_data.R')"

if [ "$1" == "--slides" ]; then
	cp .RData $slides_file func.R Slides/ 
	cd Slides && crmd $slides_file
	exit
fi

if [ "$1" == "--notes" ]; then
	cp _output.yml $notes_dir
	cp Template/* $notes_dir/Template/
	cp $notes_file $notes_dir
	cd $notes_dir && crmd $notes_file
	exit
fi

if [ "$1" == "--survey" ]; then
	cp _output.yml $notes_dir
	cp Template/* $notes_dir/Template/
	cp analysis_survey.Rmd $notes_dir
	cd $notes_dir && crmd analysis_survey.Rmd
	exit
fi


exit 0

echo "Copy files..."
cp ~/Library/Application\ Support/BibDesk/library.bib $output_dir/
cp _output.yml $output_dir
cp Template/* $output_dir/Template/
cp *.Rmd *.R .RData $output_dir
echo "Compile paper..."
cd $output_dir
crmd $report_file > report.Rout 2> report.Rerr
echo "Done!"


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





