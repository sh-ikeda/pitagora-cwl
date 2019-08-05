cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trim-galore:0.6.3--0

baseCommand: [trim_galore]
# trim_galore --trim1

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
  fq:
    label: "Input forward FASTQ file"
    doc: "Input FASTQ file"
    type: File[]
    inputBinding:
      position: 50

outputs:
  trim_galore_output_report:
    type: File[]
    outputBinding:
      glob: "*txt"
  trim_galore_output_fq:
    type: File[]
    outputBinding:
      glob: "*_trimmed.fq*"

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



