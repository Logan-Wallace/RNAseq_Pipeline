#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// Give some help messages for the user
def helpMessage() {
    log.info """
Usage:
nextflow run <ARGUMENTS>

Required Arguments:
    
    Input Data:
    --manifest <PATH>   Path to manifest file containing sample information
                        Formatted as ...

    Reference Data:
    --index <PATH>      Path to kallisto index file

    Output Location:
    --output <PATH>     Path to directory where output files will be written
    
    """.stripIndent()
}

// Create a channel for the read pairs from the manifest
Channel
    .fromPath(params.manifest)
    .splitCsv(header: true, sep: ',')
    .map { row -> tuple(row.READ_1, row.READ_2) }
    .set { read_pairs }

// Return counts files from kallisto_quant 
process kallisto_quant{
    input:
    tuple path(READ_1), path(READ_2)

    script:
    template "Kallisto_Quant.sh"
}

//Main workflow
workflow {
  read_pairs.view()
}
