# Glossary for Virtual Population Workflows

This glossary defines a minimal set of terms for working with virtual populations in Systems Pharmacology. The goal is to keep terminology concise, practical, and internally consistent.

## Target Population

The real-world population about which conclusions are intended to be made.

Example: patients with a specific disease who are eligible for a particular treatment.

## Study Population

The real patients represented in a specific study, clinical trial, observational dataset, or experimental dataset.

The study population may or may not be fully representative of the target population.

## Real Patient

An individual real patient, either as a living person or as a patient record in a dataset.

## Virtual Patient

A model instance representing one possible patient-like system.

A virtual patient is defined by a specific combination of model parameters, initial conditions, and other individual-level characteristics required to run simulations.

## Virtual Observation

A simulated result obtained from a virtual patient under a specific scenario.

Examples include simulated biomarker values, time courses, response categories, AUC values, or clinical endpoints.

A virtual observation is not the same as a virtual patient: the patient is the model instance, while the observation is a simulation output. It may differ across scenarios.

## Virtual Patient Pool

A generated or available set of virtual patients before meaningful population-level selection, filtering, weighting, or calibration.

A virtual patient pool is not necessarily a virtual population.

## Virtual Population

A set of virtual patients that has been meaningfully aligned with real-world data, biological constraints, experimental constraints, a study population, or a target population.

A virtual population does not have to be only the final result of the workflow. Intermediate sets may also be called virtual populations if they have already passed a meaningful selection, filtering, weighting, or calibration step and are used as population-like model representations.

Examples include plausible virtual population, endpoint-matched virtual population, final virtual population, target-aligned virtual population, study-specific virtual population.

## Group Definition

A formal rule that defines whether a patient belongs to a patient group.

A group definition may be based on baseline covariates, biomarkers, diagnosis, treatment assignment, response, simulated endpoints, or other explicit criteria.

When possible, the same group definition should be applied to both real patients and virtual patients.

## Patient Group

A set of real or virtual patients selected according to a group definition.

This is the general term for patient grouping and should be used when no more specific term is needed.

## Basic Workflow Terminology

A **virtual patient pool** is generated.

A **virtual population** is formed through one or more selection, filtering, weighting, or calibration steps.

**Virtual patient groups** are created using explicit group definitions.

Virtual patient groups should correspond to real patient groups whenever the same or analogous group definitions can be applied.

## Virtual Population Calibration

Alternatives: Refinement, Adjustment, Calibration, Update

We need term for creation of VPop from Virtual Patient Pool or from one VPop to another VPop, e.g. from pool to endpoint-matched, or from endpoint-matched to final.

In some cases a new VPop is created from a previous VPop, by regenerating virtual patients. This is also a form of calibration.

The specific terms can be different, like: filtering, selection, weighting, subsetting, re-generation, etc.

## Virtual Cohort

_A non-preferred synonym of "virtual population"._

Use this term only when referring to other studies. In general documentation, prefer "virtual population".

## Subpopulation

_In current usage, this term is not preferred._

Currently the meaning is the same as "virtual patient group" or "patient group".

## Digital Twin

_Currently without details_

A virtual patient that is closely aligned with a specific real patient, often with the goal of making individualized predictions or treatment decisions.

## Comments

- Currently the status of this glossary is "draft". It is expected to evolve over time as the field matures and as new terms are needed.

- Further alignment of this glossary with FDA guidance, other regulatory sources, and groups working on virtual populations in systems pharmacology is recommended.

