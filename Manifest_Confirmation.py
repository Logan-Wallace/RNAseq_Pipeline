#! usr/bin/env python3
# Author: Logan Wallace lwallac2@uoregon.edu, lwallac2@fredhutch.org
# Date: 8/24/2023

'''The purpose of this program is to read in a manifest file and make sure that all of our listed samples are evident within the location we think we have downloaded them'''


# Module import
import re
import argparse
import pandas as pd
import os
import logging

# Set up some error logging features
logging.basicConfig(filename='Manifest_Confirmation.py.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s', level=logging.DEBUG)

# Set some command line arguments
parser = argparse.ArgumentParser(
                    prog='Manifest_Confirmation.py',
                    description='The purpose of this program is to read in a manifest file and make sure that all of our listed samples are evident within the location we think we have downloaded them',
                    epilog='Good Luck!')

parser.add_argument("-m", "--manifest_filename", help = "The filename of the manifest containing sample names of the RNAseq samples", type = str, default = "/fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/RNAseq_Pipeline/Data_Logs/Meshinchi_GSC-2251A_RNA_Online_Submission-1784_21Aug2023_JS.xlsx")
parser.add_argument("-d", "--directory", help = "The path to the directory where you are checking to see that the BAM/FASTQs have been downloaded", type = str, default = "/fh/scratch/delete90/meshinchi_s/downloads")

args = parser.parse_args()

# Variable declaration
manifestFile = args.manifest_filename 
directory = args.directory
fileTypes = ["READ_1", "READ_2", "BAM"]

# Functions
def checkFile(directory, sample):
    if sample not in mappingDict:
        for fileType in fileTypes:
            manifest.at[sample, fileType] = "NOT_YET_SEQUENCED"
        return
    
    sampleName = mappingDict[sample]
    patterns = {
        'READ_1': re.compile(re.escape(sampleName) + r'_1.*.fastq.gz', re.IGNORECASE),
        'READ_2': re.compile(re.escape(sampleName) + r'_2.*.fastq.gz', re.IGNORECASE),
        'BAM': re.compile(re.escape(sampleName) + r'.*.bam', re.IGNORECASE)
    }

    found = {fileType: False for fileType in fileTypes}

    for root, dirs, files in os.walk(directory):
        for file in files:
            for fileType, pattern in patterns.items():
                if pattern.match(file):
                    # If we find a file that matched the pattern, add this to the manifest
                    manifest.at[sample, fileType] = os.path.join(root, file)
                    found[fileType] = True

    for fileType, wasFound in found.items():
        if not wasFound:
            manifest.at[sample, fileType] = "MISSING"

    manifest['Mapping'][sample] = mappingDict[sample]



# This chunk of code should only be neccessary temporarily. Once the file mapping has been provided as a part of the manifest we should no longer need for this dictionary to be created but for now I want to make sure that this code is on track and working. I also want to batch this to the Rhino compute node and make sure that I can add it to a Nextflow script before all of our files are in. 
# Load in the file mapping and create a dictionary so that we can query for a file in the dictionary and map it back to the rowname of the excel spreadsheet
mappingFilename = "/fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/RNAseq_Pipeline/Data_Logs/FileMapper.txt"
mappingDict = {}
try:
    with open(mappingFilename) as mappingFile: # Recall that the sheet indexes are 0 based
        print("File found")
        count = 0
        duplicates = 0
        for line in mappingFile:
            count += 1
            line = line.strip()
            line = line.split()
            key = line[0]
            value = line[1]
            if key in mappingDict:
                duplicates += 1
                print(key)
            mappingDict[key] = value
        print(f"Length of dictionary: {len(mappingDict)}")
        print(f"Number of lines in FileMapper.txt: {count}")
        print(f"Number of duplicates found: {duplicates}")
except FileNotFoundError:
     logging.error(f"Mapping file {mappingFilename} not found.")
     exit(1)
except Exception as e:
     logging.error(f"An error occurred when trying to read the mapping file: {e}")
     exit(1)

# Read in the manifest
# Introducing some error handling exceptions, wondering how this should be implemented when it's a part of a NextFlow pipeline?
try:
    manifest = pd.read_excel(manifestFile)
except FileNotFoundError:
     logging.error(f"Manifest file {manifestFile} not found. Please check the file path and try again.")
     exit(1)
except Exception as e:
     logging.error(f"An error occurred when trying to read the manifest file: {e}")
     exit(1)
# Get a list of these items 
samples = list(manifest['Sample ID'])

# Set TARGET_ID as rowname for simpler indexing in the checkFile function
manifest.set_index('Sample ID', inplace = True)

# Add a new column to the manifest for our tracking purposes
manifest['READ_1'] = 'NA'
manifest['READ_2'] = 'NA'
manifest['BAM'] = 'NA'
manifest['Mapping'] = 'NA'

for sample in samples:
    
    checkFile(directory, sample)

print(manifest.head)

manifest.to_excel("/fh/fast/meshinchi_s/workingDir/scripts/lwallac2/Python/RNAseq_Pipeline/sample_manifest_trial.xlsx")

