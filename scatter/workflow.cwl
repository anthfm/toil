#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: Workflow

requirements:
  - class: ScatterFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  script: File
  movieDataset: File[]
  processedDataset: string[]
  logFile: string[]

outputs:
 processed:
  type: File[]
  outputSource: step1/processed

 log:
  type: File[]
  outputSource: step1/log

hints:
  ResourceRequirement:
    coresMin: 2
    outdirMin: 5120
    ramMin: 4092 
    tmpdirMin: 45000

steps:
  step1:
    run: run.cwl
    scatter: [movieDataset, processedDataset, logFile]
    scatterMethod: dotproduct
    in:
      movieDataset: movieDataset
      script: script
      processedDataset: processedDataset
      logFile: logFile
    out: [processed, log]
