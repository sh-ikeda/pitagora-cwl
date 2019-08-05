cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trim-galore:0.6.3--0

baseCommand: [trim_galore]
# trim_galore --fastqc --trim1 --paired

arguments:
  - prefix: -o
    valueFrom: $(runtime.outdir)/$(inputs.out_dir_name)

inputs:
  show_help:
    label: "show help"
    doc: "show help"
    type: boolean
    inputBinding:
      prefix: --help
    default: false
  run_fastqc:
    label: "run fastqc"
    doc: "run fastqc"
    type: boolean
    inputBinding:
      prefix: --fastqc
    default: false
  trim_1:
    label: "trim 1base"
    doc: "trim 1base"
    type: boolean
    inputBinding:
      prefix: --trim1
    default: false
  paired_end:
    label: "paired_end"
    doc: "paired_end"
    type: boolean
    inputBinding:
      prefix: --paired
    default: false
  out_dir_name:
    label: "Name of the directory to write output to"
    doc: "Name of the directory to write output to (default: trim_galore)"                                          
    type: string
    default: "trim_galore"
  fq1:
    label: "Input forward FASTQ file"
    doc: "Input FASTQ file"
    type: File
    inputBinding:
      position: 50
  fq2:
    label: "Input reverse FASTQ file"
    doc: "Input FASTQ file"
    type: File
    inputBinding:
      position: 60

outputs:
  trim_galore_output:
    type: Directory
    outputBinding:
      glob: $(inputs.out_dir_name)

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

s:license: https://spdx.org/licenses/Apache-2.0
s:codeRepository: https://github.com/pitagora-network/pitagora-cwl
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0003-4413-0651
    s:email: mailto:bonohu@gmail.com
    s:name: Hidemasa Bono

$schemas:
  - https://schema.org/docs/schema_org_rdfa.html
  - http://edamontology.org/EDAM_1.18.owl
