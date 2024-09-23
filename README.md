Pipeline to extract gene function from threespine stickleback transcript and GFF annotation

Note that most of this pipeline is adapted from https://github.com/enormandeau/gawn and https://github.com/enormandeau/go_enrichment


#SETUP:
In 02_sequences:
two files, the Stickleback_chr.gff (see STAR_alignment pipeline for instruction) and the transcriptome.fa obtain from NCBI (`_rna.fna.gz`, must be decompressed and renamed to `transcriptome.fa`) 

Download the latest version of the swissprot database:
``` 
wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/swissprot.tar.gz
tar -zxvf swissprot.tar.gz. 
```

See the `swissprot.pjs` file to check database version.


##Running pipeline:
1) Blasting on uniprot
./01_script/01_bast_against_swissprot.sh

2) extract swissprot intro:
./01_script/02_extract_swissprot_infos.sh

3)Annotate at the transcript level (WARNING PYTHON2)
python2 ./01_script/03_annotate_transcript.py transcriptome.fa 04_annotations_transcript/genbank_info 05_annotation_table/GO_table_tr


and 3) Annotate the gff
This step agregate swissprot info for each transcript at the gene level

python3 ./01/script/04_annotate_gff.py

Then you can run the 05_goatools.sh script to perform gene ontology analysis
