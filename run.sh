#!/bin/bash

set -euo pipefail

ml nextflow/23.04.0

# Run the workflow with default settings
nextflow run main.nf \ 
--manifest /fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/RNAseq_Pipeline/sample_manifest_trial.csv \
--index /fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/RNAseq_Pipeline/Data_Logs/gencode.v29_RepBase.v24.01.idx \
--output /fh/scratch/delete90/meshinchi_s/lwallac2/Nextflow/ \
-with-report \
-resume    