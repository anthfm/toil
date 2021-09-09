#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

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
  outputSource: step1/processed

 log:
  type: File[]
  outputSource: step1/log

 processedpng:
  type: File[]
  outputSource: step2/processedpng

steps:
  step1:
    run: first.cwl
    scatter: [movieDataset, processedDataset, logFile]
    scatterMethod: dotproduct
    in:
      movieDataset: movieDataset
      script: script
      processedDataset: processedDataset
      logFile: logFile
    out: [processed, log]

  step2:
    run: second.cwl
    scatter: [processedMovieDataset]
    in:
      script2: script2
      processedMovieDataset: processedMovieDataset
    out: [processedpng]
