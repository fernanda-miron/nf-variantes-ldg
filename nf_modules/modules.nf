#!/usr/bin/env nextflow

/*Modulos de prueba para  nextflow */

process vcf_t1 {

	input:
	file vcf_file

	output:
	file "*.test"

	"""
	bcftools view --types snps ${vcf_file} > SNPs_only
		bcftools view -h SNPs_only | tail -1 | tail -c +2  > headers.tmp
		bcftools view -H SNPs_only > wheaders.tmp
		cat headers.tmp wheaders.tmp | cut -f1-5,10 > ${vcf_file}.test
		rm *.tmp
	"""
}

process vcf_t2 {

publishDir "${params.output_dir}", mode:"copy"

	input:
	file p1
	file script_R

	output:
	file "*.tsv"

	"""
	Rscript --vanilla ${script_R} ${p1}
	"""
}
