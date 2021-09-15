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

outputs:
 processedpng:
  type: File[]
  outputSource: subworkflow/processedpng


steps:
  subworkflow:
    run: 
      class: Workflow
      requirements:
        - class: ScatterFeatureRequirement
        - class: SubworkflowFeatureRequirement
      inputs: 
        script: File
        movieDataset: File
        processedDataset: string
        logFile: string
        script2: File

      outputs:
       processedpng:
        type: File
        outputSource: step2/processedpng


      steps:
        step1:
          run: first.cwl
          in:
            script: script
            movieDataset: movieDataset
            processedDataset: processedDataset
            logFile: logFile
          out: [processed, log]
        
        step2:
          run: second.cwl
          in:
            script2: script2
            processedMovieDataset: step1/processed
          out: [processedpng]
    
    scatter: [movieDataset, processedDataset, logFile]
    scatterMethod: dotproduct
    in: 
      script: script
      movieDataset: movieDataset
      processedDataset: processedDataset
      logFile: logFile
      script2: script2
    out: [processedpng]
