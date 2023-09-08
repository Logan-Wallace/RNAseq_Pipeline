#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// Import jobs that will comprise workflow
include { kallisto_quant } from './Modules/Kallisto_Quant.nf'

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

    // print the manifest to the terminal
    println params.manifest

    Channel
        .fromPath(params.manifest)
        .splitCSV(header: true, sep: ',')
        .map { row -> tuple(row.READ_1, row.READ_2) }
        .set{ read_pairs }  
    // // If all the neccessary params have been found
    // if (params.manifest && params.output && params.index){
    //     // Create a channel called 'read_pairs' to pass the file paths for read_1 and read_2 from the manifest to the kallisto_quant process
    //     Channel
    //         .fromPath(params.manifest)
    //         .splitCSV(header: true, sep: ',')
    //         .map { row -> tuple(row.READ_1, row.READ_2) }
    //         .set{ read_pairs }  
    // } else {
    //     // If not all the neccessary params have been found, print the help message
    //     helpMessage()
    // }

    // Run the kallisto_quant process for each pair of reads using the read_pairs channel  
    //kallisto_quant(read_pairs)

}
