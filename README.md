# DigiPopRecipes

**DigiPopRecipes** is a curated collection of methods, workflows, and examples for generating and analyzing virtual patients in Quantitative Systems Pharmacology (QSP), using the Julia programming language.

## Purpose

This repository aims to:
- Demonstrate various approaches to virtual population generation.
- Compare different analysis strategies on consistent model examples.
- Serve as a tutorial and practical guide for modelers working in QSP.
- Provide reusable Julia code for each step of the workflow.

## Contents

```
docs/                         # Documentation and explanations of methods.
models/                       # QSP reusable model packages.
    01-multicompartment-pkpd/ # A simple multicompartment PK/PD model.
        src/                  # dynamic system model code.
        tests/                # code for manual testing
        scenarios/            # description of conditions
        cohorts/              # population variability specifications
            profile-1/        # specifications and code for generating sampling profile.
    ...
data/                         # Synthetic datasets generated from the models for analysis examples.
    01-multicompartment-pkpd/ # Data generated from the multicompartment PK/PD model.
        profile-1/            # a dataset for specific cohort and scenario.
        ...
    ...
recipes/                      # Method-specific pipelines and analysis examples.
```

## Related Projects

- [DigiPopData.jl](https://github.com/hetalang/DigiPopData.jl) – A Julia package for managing clinical endpoint data used in digital population workflows.
- [Heta project](https://hetalang.github.io/) – An open-source initiative developing advanced tools and best practices for dynamic system modeling in pharmacology, PK/PD, QSP, and systems biology.

## Contribution

Contributions and discussions are welcome! Please open an issue or pull request if you want to suggest an approach, contribute an example, or request a feature.

## License

- Code in this repository is licensed under the MIT License, see [`LICENSE`](LICENSE) for details.
- Documentation and methodological materials are licensed under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](./LICENSE-CC-BY)