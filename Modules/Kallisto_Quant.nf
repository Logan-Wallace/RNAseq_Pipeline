#!/usr/bin/env nexflow

// Using DSL-2
nextflow.enable.dsl=2

// Return counts files from kallisto_quant 
process kallisto_quant {
    input:
    tuple path(index), path(R1), path(R2), path(output) 

    output:
    path()

    script:
    template 'Kallisto_Quant.sh'
}

