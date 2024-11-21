# Make your data processing and analysis reproducible with conda and snakemake

Researchers often face the issue of reproducibility 
-- not just the replicability of published research results, 
or working with teamates.
But more often, is with the researcher themselves.

How much effort have you spent to fit multiple projects into your computer, when each of them is dependent on a unique set of software packages and applications?

How much effort have you spent to revive a project for the revision of a manuscript that you have done 6 months ago or 2 years ago?

There are a variety of tools to make your pipeline reproducible, and in this workshop we discuss the following two:

- conda: a virtual environment and package manager

- snakemake: a pipeline orchestrator

This workshop is part of the 2024 IEU retreat workshops, and will be delievered by Zhaozhen Xu and Yi Liu.

## Pre-course steps

We assume you have had some prior experiences with the Bash shell, and to fully benefit from the workshop please follow the basic steps below. 
Nevertheless if you are less experienced, you should also be able to learn something during the workshop.

### Setting up the conda environment

You should first get conda from the options below, 
and install conda following the instruction from the respective options

- the miniconda distribution https://docs.anaconda.com/miniconda/install/
- the anaconda distribution https://www.anaconda.com/download

After conda is installed and **callable** from the command line, create the conda environment at the **project root** by

```
conda env create -f environment.yml
```

Then activate the environment by

```
conda activate ieu-conda-snakemake-practice
```

### Running the snakemake pipeline