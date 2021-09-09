#!/usr/bin/env cwl-runner
2
3cwlVersion: v1.0
4class: Workflow
5
6requirements:
7  - class: ScatterFeatureRequirement
8
9inputs:
10  script: File
11  movieDataset: File[]
12  processedDataset: string[]
13  logFile: string[]
14  script2: File
15  processedMovieDataset: File[]
16
17outputs:
18 processed:
19  type: File[]
20  outputSource: step1/processed
21
22 log:
23  type: File[]
24  outputSource: step1/log
25
26 processedpng:
27  type: File[]
28  outputSource: step2/processedpng
29
30steps:
31  step1:
32    run: first.cwl
33    scatter: [movieDataset, processedDataset, logFile]
34    scatterMethod: dotproduct
35    in:
36      movieDataset: movieDataset
37      script: script
38      processedDataset: processedDataset
39      logFile: logFile
40    out: [processed, log]
41
42  step2:
43    run: second.cwl
44    scatter: [processedMovieDataset]
45    in:
46      script2: script2
47      processedMovieDataset: step1/processed
48    out: [processedpng]
