#!/bin/bash
awk -F '\t' '{if($8 ~ /Pseudomonas/) print $1","$2","$3","$5","$8","$11","$12","$14","$15","$16","$20}' assembly_summary.txt > assembly_summary_complete_genomes_Pseudomonas.txt
