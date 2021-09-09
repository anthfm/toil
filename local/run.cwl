#!/usr/bin/env cwl-runner
cwlVersion: v1.0
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


baseCommand: [python]

outputs:
 processed:
  type: File
  outputBinding:
   glob: movie_review_nltk.csv

 log:
  type: File
  outputBinding:
   glob: demo.log
