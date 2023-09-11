
// Return counts files from kallisto_quant 
process kallisto_quant {

    input:
    tuple path(READ_1), path(READ_2) from read_pairs
    path index
    path output

    script:
    template "Kallisto_Quant.sh"
}
