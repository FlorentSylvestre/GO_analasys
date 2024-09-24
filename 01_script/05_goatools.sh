#!/bin/bash

## srun -p small -c 1 -J 05_goatools -o 05_goatools_%j.log /bin/sh 01_script/05_goatools.sh target_ID background_ID output


##Run goatools on a target a background gene list
# Target ID is the list of all gene of interest (one by row)
# background_ID is the list of all studied gene (tested universe)
# output is the name of the output file (will be located in 07_GO_analysis)

# annotation is the file outputted by 04_annotate_gff.py 

##Command line arguments
target_ID=$1
background_ID=$2  
output=$3

##Fixed variables
annotation="05_annotation_table/GFF_gene_annotation_hits.txt" 
go_db="07_GO_analysis/go-basic.obo"

##Check if database exists:
if [ ! -f $go_db ];then
        wget -P "07_GO_analysis/" http://geneontology.org/ontology/go-basic.obo
fi

##createtmp_file with GO annotation only:
cut -f1,8 $annotation | perl -pe "s/-;//" > tmp_go   # extract gene LOC and its GO terms (1st and 8th fields)

find_enrichment.py --pval=0.05 --indent\
    --obo $go_db\
    $target_ID \
    $background_ID \
    ./tmp_go --outfile 07_GO_analysis/$output

rm tmp_go
