#!/bin/bash

set -euo pipefail

echo "Index File: $index"
echo "Read_1: $R1"
echo "Read_2: $R2"
echo "Output Directory - $output"

echo "Starting Kallisto_Quant for $(basename "$R1")"

kallisto quant -i $index -o $output -b 30 -t 4 --fusion --bias --rf_stranded $R1 $R2

echo "Completed Kallisto_Quant for $(basename "$R1")"