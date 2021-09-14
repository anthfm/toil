#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  script: File
  movieDataset: File[]
  processedDataset: string[]
  logFile: string[]
  script2: File
  processedMovieDataset: File[]

outputs:
 processed:
  type: File[]
  outputSource: subworkflow/processed

 log:
  type: File[]
  outputSource: subworkflow/log

 processedpng:
  type: File[]
  outputSource: subworkflow/processedpng


steps:
  subworkflow:
    run: 
      class: Workflow
      inputs: 
        inputds: File
        processds: string
        logf: string
        scr: File
        scr2: File
      outputs:
       processed:
        type: File
        outputSource: step1/processed

       log:
        type: File
        outputSource: step1/log

       processedpng:
        type: File
        outputSource: step2/processedpng

      steps:
        step1:
          run: first.cwl
          in:
            movieDataset: inputds
            processedDataset: processds
            logFile: logf
            script: scr
          out: [processed, log]
        step2:
          run: second.cwl
          in:
            script2: scr2
            processedMovieDataset: step1/processed
          out: [processedpng]
    
    scatter: [inputds, processds, logf]
    scatterMethod: dotproduct
    in: 
      inputds: movieDataset
      processds: processedDataset
      logf: logFile
      scr: script
      scr2: script2
    out: [processed, log, processedpng]
