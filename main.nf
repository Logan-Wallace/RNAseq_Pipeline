#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// Import jobs that will comprise workflow
include { kallisto_quant } from './kallisto_quant.nf'

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


//Main workflow
workflow{
    
}
