# RNAseq_Processing_Pipeline
A pipeline to process RNAseq data for the Meshinchi Lab

### Purpose
The purpose of this pipeline is to generate summary files from FASTQ and BAM files returned from external collaborators after samples have been sent for RNA sequencing.

### Nextflow Quick Notes 
The Nextflow structure within this repository exists at a few different levels. The framework for the entire workflow is in the main.nf script. This nextflow script is informed by the nextflow.gizmo.config file which passes parameters that the nextflow script operates within. The 'Modules' folder holds individual Nextflow scripts that run portions of the larger workflow. I like to think of these as 'jobs' inside the workflow. These modules reference some sort of script to complete the 'job'. Bash, Python, R, etc. This workflow is batched to the Gizmo compute cluster managed by SLURM by a run.sh script. 
You can see a great example written by Sam Minot in 'References' below.

## Usage


## References
https://github.com/FredHutch/workflow-template-nextflow/blob/main/modules/align.nf
https://sciwiki.fredhutch.org/hdc/workflows/workflow_background/