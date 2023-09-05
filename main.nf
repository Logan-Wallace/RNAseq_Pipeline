#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

// Import jobs that will comprise workflow
include { Manifest_Confirmation } from './Manifest_Confirmation.nf'
include { kallisto_quant } from './kallisto_quant.nf'

// Give some help messages for the user
def helpMessage() {
    log.info """
Usage:
    
nextflow run 

Required Arguments:
    
    


}