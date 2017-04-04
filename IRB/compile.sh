#!/bin/bash
output_dir="Application"

rm $output_dir/*

echo "Profiles\n========="
echo "Compile recruitment..."
pandoc profiles_recruit.txt -o $output_dir/profiles_recruit.pdf
echo "Compile consent..."
pandoc profiles_consent.txt -o $output_dir/profiles_consent.pdf
echo "Compile profile ask..."
pandoc profiles_ask.txt -o $output_dir/profiles_ask.pdf
echo "Compile consent for cler..."
pandoc cler_consent.txt -o $output_dir/cler_consent.pdf
## Survey for cler ... 

echo "\nSurvey\n========="
echo "Compile recruit survey..."
pandoc survey_recruit.txt -o $output_dir/survey_recruit.pdf
echo "Compile survey questions..."
pandoc survey_questions.txt -o $output_dir/survey_questions.pdf

echo "\nSolicitation\n=============="
echo "Compile solicitation..."
pandoc solicitation_body.txt -o $output_dir/solicitation.pdf
echo "Compile debriefing..."
pandoc debrief.txt -o $output_dir/debrief.pdf 

echo "\nOther supporting material\n=============="
echo "Copy CUHS..."
cp CUHS_Protocol_Template_v4.doc $output_dir
echo "Compile tracked variables..."
pandoc list_variables.txt -o $output_dir/list_variables.pdf
echo "Copy email from HeroX..."
cp permission_herox.pdf $output_dir

echo "Done!"



