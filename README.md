# Proximity Index Calculation Method

## Overview
This document describes the method for calculating the Proximity Index (PI),
a measure quantifying divergence in visual exploration. It compares gaze data
between a referent group and a comparison group, applicable in various research contexts and type of stimuli (static vs. dynamic).

## Method Description

### Reference Gaze Pattern Generation
- Generate referent gaze patterns using a probability density estimation
  function on the gaze data of the referent group.
- These patterns serve as a benchmark for comparison.

### Proximity Index Calculation
- Calculate the PI for each gaze data frame for individuals in the comparison group.
- Compare gaze data points to the referent distribution for each frame.
- Scale PI values from 0 to 1, where lower values indicate higher divergence.

## Requirements
- Matlab (any release)

## Input Data Format
  The function requires a 3D array input with the following dimensions: Gaze Coordinates (2D) X Number of Frames X Number of Subjects


## References
- "Unraveling the Developmental Dynamic of Visual Exploration of Social Interactions"
  [Authors]
  bioRxiv 2020.09.14.290106; doi: [https://doi.org/10.1101/2020.09.14.290106](https://doi.org/10.1101/2020.09.14.290106)
