#!/usr/bin/env cwl-runner
cwlVersion: v1.1
class: CommandLineTool

inputs:

 script:
   type: File
   inputBinding:
      position: 1

 movieDataset:
   type: File
   inputBinding:
      position: 2
      prefix: -i

 processedDataset:
   type: string
   inputBinding:
      position: 3
      prefix: -o

 logFile:
   type: string
   inputBinding:
      position: 4
      prefix: -l  


baseCommand: [python3]

outputs:
 processed:
  type: File
  outputBinding:
   glob: "*.csv"

 log:
  type: File
  outputBinding:
   glob: "demo*.log"
