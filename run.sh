#!/bin/bash

set -euo pipefail

ml nextflow/23.04.0

# Run the workflow with default settings
nextflow run main.nf \ 
--manifest sample_manifest_trial.csv \
--index gencode.v29_RepBase.v24.01.idx \
--output /fh/scratch/delete90/meshinchi_s/lwallac2/Nextflow/ \
-with-report \
-resume    