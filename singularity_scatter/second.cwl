#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: imanthonny/pyth

inputs:

 script2:
   type: File
   inputBinding:
      position: 1

 processedMovieDataset:
   type: File
   inputBinding:
      position: 2


baseCommand: [python3]

outputs:
 processedpng:
  type: File
  outputBinding:
   glob: "*.png"