#!/bin/bash

# Adequately identify each of the tables downloaded from IDEAMEX.
# Once this is done, it performs a loop to extract fields 1 and NF (last field),
# which correspond to the ID and the direction of the expression (Up or Down). 
# This script will overwrite the original file, save a copy in a safe place.

for file in *_intersect.txt;
do
	# We extract column 1 and NF and overwrite the original file.
	echo "Processing $archivo"
    awk -F'\t' '{print $1 "\t" $NF}' "$file" > "new_$file"

done

# Shows all the new files, removes the headers and searches for all the Up genes
# of the specified condition/tissue, sorts them, checks if there are repetitions
# and generates a new file for each of the conditions where only the UPs will be for each condition/tissue.

tissues=("Up_muscle" "Up_hep" "Up_hemocytes" "Up_pleopods" "Up_gills" "Up_ovary")

for tissue in ${tissues[@]};
do
	grep -v 'ID' new*.txt | grep "${tissue}" | cut -d ':' -f2- | cut -f1 | sort | uniq -c | awk '$1 == 5 {print $2}' > ${tissue}.txt 
done

