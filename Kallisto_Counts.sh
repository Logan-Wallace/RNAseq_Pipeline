#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --mem=100G
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --job-name="Kallisto_Count"
#SBATCH --output=.%j.out


# Scicomp reccommends this to allow me to access the module commmands
source /app/lmod/lmod/init/profile

set -eou pipefail

# # Note that the 'ml' and 'module' commands are the same command=
# ml purge
# ml Apptainer/1.1.6
# # This pulls down the image from docker and will not have to be run again
# # apptainer pull docker://jennylsmith/kallistov45.0:nextflow # note that the other version of the image doesn't 
# # Fire up our environment from the pulled image
# apptainer run kallistov45.0_nextflow.sif

# None of the above was working, so I'm just going to load the Kallisto module here
ml kallisto/0.45.0-foss-2018b

index="/fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/BCCA_File_Download/RNAseq_Processing_Pipeline/gencode.v29_RepBase.v24.01.idx"
output="/fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/BCCA_File_Download/RNAseq_Processing_Pipeline/"
R1="/fh/scratch/delete90/meshinchi_s/downloads/F126920/150bp/F126920_1_150bp_4_lanes.merge_chastity_passed.fastq.gz"
R2="/fh/scratch/delete90/meshinchi_s/downloads/F126920/150bp/F126920_2_150bp_4_lanes.merge_chastity_passed.fastq.gz"


kallisto quant -i $index -o $output -b 30 -t 4 --fusion --bias --rf-stranded $R1 $R2 2> $(basename "$R1").kallisto.out
#  --fusion --bias --rf-stranded  $R1 $R2 2> ${R1.simpleName}.kallisto.out

echo "Hello, Logan. Your script ran on Rhino!"