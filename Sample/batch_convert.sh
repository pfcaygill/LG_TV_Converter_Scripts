#!/bin/bash
# https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory
input_file_type="*.mkv"

echo "Changing to top of batching directory at"
echo "$top_level_path"
cd $1

input_match="${input_file_type}"
out_str_match="[sS][0-9]+[eE][0-9]+"

for filename in $input_match; do
    echo $filename | grep -e "${out_str_match}"
    grep -i -e "[sS][0-9]+[eE][0-9]+" <<<$filename
    outputstr=$(grep -i -e "S[0-9]+E[0-9]+" <<<$filename)
    echo "file $outputstr"
done 

echo "script complete"
read