#!/bin/bash

# Run the workflow with default settings
nextflow run main.nf -with-report -resume \ 
--manifest sample_manifest_trial.csv \
--index gencode.v29_RepBase.v.24.01.idx \
--output /fh/scratch/delete90/meshinchi_s/lwallac2/Nextflow/