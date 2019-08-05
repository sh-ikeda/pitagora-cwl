cwlVersion: v1.0
class: Workflow

inputs:
  ## Common input
  nthreads: int

  ## Inputs for download-sra
  repo: string?
  run_ids: string[]

  ## Inputs for hisat2_mapping
  hisat2_idx_basedir: Directory
  hisat2_idx_basename: string

  ## Inputs for stringtie
  annotation: File
  reference_only: boolean?
  gene_tpm_output_filename: string?
  output_filename: string?

outputs:
  assemble_output:
    type: File
    outputSource: stringtie_assemble/assemble_output
  gene_tpm_output:
    type: File
    outputSource: stringtie_assemble/gene_tpm_output
  trim_report:
    type: File[]
    outputSource: trim_galore-se/trim_galore_output_report

steps:
  download-sra:
    run: download-sra.cwl
    in:
      repo: repo
      run_ids: run_ids
    out:
      [sraFiles]

  pfastq-dump:
    run: pfastq-dump.cwl
    in:
      sraFiles: download-sra/sraFiles
      nthreads: nthreads
    out:
      [fastqFiles]

  trim_galore-se:
    run: trim_galore-se.cwl
    in:
      fq: pfastq-dump/fastqFiles
      trim_1: { default: true }
    out:
      [trim_galore_output_report, trim_galore_output_fq]

  hisat2_mapping:
    run: hisat2_mapping_se.cwl
    in:
      hisat2_idx_basedir: hisat2_idx_basedir
      hisat2_idx_basename: hisat2_idx_basename
      fq: trim_galore-se/trim_galore_output_fq
      nthreads: nthreads
    out:
      [hisat2_sam]

  samtools_sam2bam:
    run: samtools_sam2bam.cwl
    in:
      input_sam: hisat2_mapping/hisat2_sam
    out: [bamfile]

  samtools_sort:
    run: samtools_sort.cwl
    in:
      input_bam: samtools_sam2bam/bamfile
      nthreads: nthreads
    out: [sorted_bamfile]

  stringtie_assemble:
    run: stringtie_assemble.cwl
    in:
      input_bam: samtools_sort/sorted_bamfile
      nthreads: nthreads
      annotation: annotation
      reference_only: reference_only
      gene_tpm_output_filename: gene_tpm_output_filename
      output_filename: output_filename
    out: [gene_tpm_output, assemble_output]

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

s:license: https://spdx.org/licenses/Apache-2.0
s:codeRepository: https://github.com/pitagora-network/pitagora-cwl
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0003-3777-5945
    s:email: mailto:inutano@gmail.com
    s:name: Tazro Ohta

$schemas:
  - https://schema.org/docs/schema_org_rdfa.html
  - http://edamontology.org/EDAM_1.18.owl
