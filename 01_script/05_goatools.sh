#!/bin/bash

##Run goatools on a target a background gene list
##goatools.sh target_ID background_ID output
# Target ID is the list of all gene of intereste (one by row)
# background_ID is the list of all studied gene (tested universe)
# output is the name of the output file (will be located in 07_GO_analysis)

##Command line arguments
target_ID=$1
background_ID=$2
output=$3

##Fixed variables
annotation="03_data/GFF_gene_annotation.txt"
go_db="07_GO_analysis/go-basic.obo"

##Check if database exists:
if [ ! -f $go_db ];then
        wget -P "07_GO_analysis/" http://geneontology.org/ontology/go-basic.obo
fi

##createtmp_file with GO annotation only:
cut -f1,7 $annotation| perl -pe "s/-;//" >tmp_go

find_enrichment.py --pval=0.05 --indent\
    --obo $go_db\
    $target_ID \
    $background_ID \
    ./tmp_go --outfile 07_GO_analysis/$output

rm tmp_go
