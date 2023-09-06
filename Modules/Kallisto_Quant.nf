#!/usr/bin/env nexflow

// Using DSL-2
nextflow.enable.dsl=2

index = file("${params.index}")
output = path(params.output)

// Return counts files from kallisto_quant 
process kallisto_quant {
    input:
    set path(R1), path(R2) from read_pairs
    
    script:
    template 'Kallisto_Quant.sh'
}

