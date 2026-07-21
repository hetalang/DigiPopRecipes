# Generate, Filter, Select

> Draft document. This strategy may change as the workflow is developed.

## Overview

This document describes one strategy for creating a virtual population. Other strategies will be described in separate documents.

## Input data

- A QSP model as a system of ordinary differential equations (ODEs), with parameter values that are currently used as initial guesses.
- Data that can be divided into the following types:
  - **Parameter data** — direct values of model parameters, such as known binding constants and organ volumes. These are fixed parameter values.
  - **Average-patient data** — data that the model can describe only at the average-patient level, such as mean concentrations. These data do not describe between-patient variability; measurement error is not considered variability. The data can be values at individual time points or time courses.
  - **Population data** — data describing a patient population, usually obtained in clinical studies:
    - **Individual data** — individual observations, such as plasma concentrations for each patient at each time point. Along with the measurements, study conditions, sample size, inclusion and exclusion criteria, and other relevant characteristics should be recorded.
    - **Summary data** — data without individual observations, such as calculated mean values, quantiles, and survival curves.
    - **Plausibility bounds** — acceptable ranges of measurement values or parameter values. The source of these ranges is not always clear, but they occur in the literature and in real projects. For example, minimum and maximum acceptable plasma concentrations can be defined. These data can be used to exclude virtual patients and reduce the size of the virtual patient pool, which may reduce computational cost.

## Steps

### Classify parameters

At this stage, the model structure is assumed to be defined and will not change during the workflow.
We work only with parameter values or sets of parameter values.

Parameters should be divided into the following types:

- **Known fixed parameter** — a fixed parameter with a known value that is the same for all patients.
- **Unknown fixed parameter** — a fixed parameter with an unknown value that is the same for all patients.
- **Uninformed random parameter** — a variable parameter with an unknown distribution.
- **Mean-informed random parameter** — a variable parameter with a known mean and an unknown distribution.

A **Mean-informed random parameter** may have both a known mean and a known distribution. In this case, use only the mean and ignore the known distribution.

### Prepare the average patient

Use **Average-patient data**, **Individual data**, and **Summary data**. Use only mean or median values and ignore variability.
Fix **Known fixed parameter** and **Mean-informed random parameter**.
Estimate **Unknown fixed parameter** and **Uninformed random parameter** by model fitting.

Check the quality of the model fit. If it is acceptable, continue to the next step. Otherwise, return to earlier steps or revise the model.

### Analyze sensitivity

Use the estimated parameters as initial or mean values and perform sensitivity analysis.
Rank the parameters by their effect on model outputs, taking into account differences in parameter scales and orders of magnitude.
Parameters should be transformed to a comparable scale, for example by log transformation, normalization, or other suitable transformations.

Rank the parameters from most sensitive to least sensitive.
Select N most sensitive parameters. N can be set to, for example, 10 parameters when later steps are computationally expensive, or to a chosen quantile, such as 10%. Fix the remaining parameters at the optimal values obtained in the previous step.

> It needs to be clarified whether sensitivity analysis should be performed only for experimental data or also for predictive model outputs.

The result is the following parameter groups:

- Fixed parameters: **Known fixed parameter** values are known from the start; **Unknown fixed parameter** values are estimated for the average patient; other parameters are fixed because they have no important effect on model outputs.
- Variable parameters: the selected **Uninformed random parameter** and **Mean-informed random parameter**. A total of N parameters are selected; their mean values are approximately known from the average-patient model.

### Generate a virtual patient pool

Define a distribution for each of the N selected variable parameters. Different choices are possible, but at this stage a lognormal distribution with the selected mean and a sufficiently wide spread seems reasonable because it reflects uncertainty.

Use Monte Carlo simulation to generate M virtual patients by randomly sampling the values of the variable parameters from the specified distributions. The choice of M is not obvious. A useful starting point may be at least 10^4 patients, but available resources and the time needed for later steps should be considered.

At this stage, a virtual patient pool is created. Save only virtual observations relevant to **Individual data** and **Summary data**, because they will be used for selection. Also save all variable parameters so that their distributions in the selected virtual population can later be analyzed or used for prediction.

### Filter the virtual patient pool

Use **Plausibility bounds** to filter the virtual patient pool.

This produces a filtered virtual population of size m < M.
Call it a plausible virtual population.

### Select the optimal virtual population

Set the target size of the virtual population, for example k = 100 < m. The task is to select a subset of k virtual patients from the plausible virtual population that best describes **Individual data** and **Summary data**.

The approach for **Individual data** still needs to be clarified.

- **Individual data** can be converted into summary metrics, that is, into **Summary data**.
- A metric can be developed to compare individual data with model predictions for each virtual patient.

Code for **Summary data** is already available in `DidiPopData.jl`.
Then, define a residual function and use the VPopMIP method.

### Check the quality of the selected virtual population

Visualize:

1. The selected virtual population and the data (best virtual population vs. data): does it match the data well enough?
2. The selected and plausible virtual populations (best virtual population vs. plausible virtual population): how much does the selection algorithm improve the match to the data?

### Analyze the selected virtual population

### Make predictions
