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
3. [Activate environment & start Jupyter](#activate-environment-jupyter)  
4. [Day 1: Notebook & example commands](#day-1-notebook--example-commands)  
5. [Recommended folder structure](#recommended-folder-structure)  
6. [Further resources & contact](#further-resources--contact)

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

## environment.yml

Save this as *environment.yml* in the repo root (or copy/paste into your terminal):
```yaml
name: polymer_md
channels:
  - conda-forge
  - dacase
dependencies:
  - python=3.10
  - amberclassic        # AmberClassic / AmberTools (Linux/macOS via dacase)
  - gromacs             # GROMACS from conda-forge
  - parmed              # topology conversion utilities
  - openbabel           # SMILES <-> 3D formats
  - rdkit               # optional: SMILES → 3D via RDKit (may be heavy on macOS/ARM)
  - pip
  - pip:
      - packmol-memgen   # PACKMOL python wrapper
      - jupyter
```

Notes:
- amberclassic (dacase channel) currently supports linux-64 and osx-64. On Apple Silicon (M1/M2) you may need to use osx-64 emulation or run in x86_64 environment (or use Linux/WSL).
- If rdkit causes issues on your platform, install only openbabel and use obabel for 3D conversion.

## Activate environment & start jupyter lab
```bash
conda activate polymer_md

# Verify core tools
gmx --version           # GROMACS
antechamber -h          # AmberClassic / Antechamber
parmchk2 -h             # Parmchk2
tleap -h                # tleap (Amber)
obabel -V               # Open Babel
python -c "import packmol_memgen; print('packmol OK')"
jupyter --version
```
If any command is missing, re-check the environment creation step or install individually:
```bash
conda install -c conda-forge gromacs parmed openbabel
conda install -c dacase amberclassic
pip install packmol-memgen jupyter
```
If antechamber / tleap not found
- Ensure you sourced Amber environment (the Conda package should place executables on PATH). If needed:
```bash
source $CONDA_PREFIX/AmberClassic.sh
```

To start the remote JuoyterLab without SSH tunneling, run this in the project directory:
```bash
jupyter lab --ip 0.0.0.0 --no-browser
```
JupyterLab will print a URL similar to, this should open a new tab in the browser:
```text
http://localhost:8888/lab?token=abc123...

```
Learn the JupyterNotebook basics here: https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Notebook%20Basics.html
Learn the JupyterLab interface here: https://jupyterlab.readthedocs.io/en/4.4.x/user/interface.html


## Day 1: Notebook & example commands

Purpose: demonstrate a compact AmberTools workflow:
	1.	Convert SMILES → 3D PDB (OpenBabel)
	2.	Run antechamber to assign GAFF atom types & AM1-BCC charges
	3.	Run parmchk2 to generate missing force-field terms (.frcmod)
	4.	Use tleap to create prmtop and inpcrd files

Example commands (from notebook)
```bash
# 1. SMILES -> 3D PDB (OpenBabel)
obabel -:"CCO" -O ethanol.pdb --gen3d

# 2. Antechamber: generate mol2 and AM1-BCC charges
antechamber -i ethanol.pdb -fi pdb -o ethanol.mol2 -fo mol2 -c bcc -s 2

# 3. Parmchk2: create frcmod
parmchk2 -i ethanol.mol2 -f mol2 -o ethanol.frcmod

# 4. tleap: build prmtop/inpcrd
cat > tleap_ethanol.in << 'EOF'
source leaprc.gaff
ETH = loadmol2 ethanol.mol2
loadamberparams ethanol.frcmod
saveamberparm ETH ethanol.prmtop ethanol.inpcrd
quit
EOF

tleap -f tleap_ethanol.in
```
The Day-1 notebook contains these steps with explanatory text and cells you can run interactively.