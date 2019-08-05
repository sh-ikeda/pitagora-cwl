cwlVersion: v1.0
class: CommandLineTool
label: "StringTie: Transcript assembly and quantification for RNA-Seq"
doc: "StringTie is a fast and highly efficient assembler of RNA-Seq alignments into potential transcripts. It uses a novel network flow algorithm as well as an optional de novo assembly step to assemble and quantitate full-length transcripts representing multiple splice variants for each gene locus. Its input can include not only the alignments of raw reads used by other transcript assemblers, but also alignments longer sequences that have been assembled from those reads. https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual"

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/stringtie:1.3.0--hd28b015_2

baseCommand: [stringtie]

arguments:
  - prefix: -o
    valueFrom: $(runtime.outdir)/$(inputs.output_filename)

inputs:
  input_bam:
    label: "Sorted BAM file"
    doc: "a BAM file with RNA-Seq read mappings which must be sorted by their genomic location"
    type: File
    inputBinding:
      position: 0
  output_filename:
    label: "The name of the output GTF file"
    doc: "Sets the name of the output GTF file where StringTie will write the assembled transcripts."
    type: string
    default: "stringtie_out.gtf"
  nthreads:
    label: "The number of processing threads"
    doc: "Specify the number of processing threads (CPUs) to use for transcript assembly. The default is 1."
    type: int
    default: 1
    inputBinding:
      prefix: -p
  annotation:
    label: "The reference annotation file"
    doc: "Use the reference annotation file (in GTF or GFF3 format) to guide the assembly process. The output will include expressed reference transcripts as well as any novel transcripts that are assembled."
    type: File
    inputBinding:
      prefix: -G
  reference_only:
    type: boolean?
    label: "Only estimate the abundance of given reference transcripts"
    doc: "Limits the processing of read alignments to only estimate and output the assembled transcripts matching the reference transcripts given with the -G option. With this option, read bundles with no reference transcripts will be entirely skipped, which may provide a considerable speed boost when the given set of reference transcripts is limited to a set of target genes, for example."
    inputBinding:
      prefix: -e
  gene_tpm_output_filename:
    type: string?
    label: "Gene abundance estimation output file"
    doc: "Gene abundances will be reported in the output file with the given name."
    inputBinding:
      prefix: -A
outputs:
  assemble_output:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)
  gene_tpm_output:
    type: File?
    outputBinding:
      glob: $(inputs.gene_tpm_output_filename)

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
