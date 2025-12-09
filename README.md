# Polymer MD Workshop — Environment & Quickstart

This repository provides everything needed to run the hands-on **Polymer MD** workshop:
- Conda-based environment (AmberClassic, GROMACS, ParmEd, OpenBabel/RDKit, PACKMOL, Jupyter)
- `environment.yml` for one-command setup
- Starter **Day 1** notebook: parameterize a small molecule with Antechamber
- Recommended folder structure, example commands, and troubleshooting tips

> **Goal:** enable participants to build polymer systems from SMILES, parameterize monomers, convert topologies, run GROMACS workflows, and analyze polymer properties.

---

## Table of contents
1. [Quick setup (one command)](#quick-setup-one-command)  
2. [environment.yml (copy/paste)](#environmentyml)  
3. [Activate environment & verify](#activate-environment--verify)  
4. [Day 1: Notebook & example commands](#day-1-notebook--example-commands)  
5. [Typical workflow summary](#typical-workflow-summary)  
6. [Recommended folder structure](#recommended-folder-structure)  
7. [Troubleshooting & notes](#troubleshooting--notes)  
8. [Further resources & contact](#further-resources--contact)

---

## Quick setup (one command)

1. Install Miniconda / Anaconda (if not already installed):  
   https://www.anaconda.com/docs/getting-started/miniconda/install

2. From the repository root, create the environment and activate it:

```bash
# create environment from environment.yml (provided below)
conda env create -f environment.yml

# activate
conda activate polymer_md
```
If you prefer manual installation, see the package list in the environment.yml section and install with conda install and pip per your OS.