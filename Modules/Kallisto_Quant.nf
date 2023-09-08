#!/usr/bin/env nexflow

// Using DSL-2
nextflow.enable.dsl=2

println params.manifest

read_pairs.view()

index = params.index

println index

// //Print out the index and output paths to make sure they are correct
// println index
// println output

// // Return counts files from kallisto_quant 
// process kallisto_quant {
//     input:
//     tuple path(R1), path(R2) from read_pairs
//     path index
//     path output

//     script:
//     template 'Kallisto_Quant.sh'
// }
