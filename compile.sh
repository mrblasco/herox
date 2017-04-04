#!/bin/bash
output_dir=Paper

# Slides
if [ "$1" == "--slides" ]; then
	cp .RData deck.Rmd func.R Slides/ && cd Slides && crmd deck.Rmd
fi

# Paper
cp ~/Library/Application\ Support/BibDesk/library.bib $output_dir/
cp _output.yml $output_dir
cp *.Rmd $output_dir
cp Template/* $output_dir/Template/
cd $output_dir && crmd report.Rmd
exit
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





