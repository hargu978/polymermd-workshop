# Polymer MD Workshop — Setup Guide

This guide provides step-by-step instructions to set up the environment for the **Polymer MD Workshop**.

---

## Table of Contents
1. [Quick Install](#quick-install)
2. [Step 1: Install Conda](#step-1-install-conda)
3. [Step 2: Create the Conda Environment](#step-2-create-the-conda-environment)
4. [Step 3: Start Jupyter Lab](#step-3-start-jupyter-lab)
5. [Notes](#notes)
6. [Day 1: Notebook & Example Commands](#day-1-notebook--example-commands)

---

## Quick Install

To quickly set up the environment, use the provided `setup_conda_env.sh` script.

### Steps:
1. Download the GitHub repository containing the workshop scripts:
   ```bash
   # Using wget
   wget https://github.com/hargu978/polymermd-workshop/archive/refs/heads/main.zip -O polymermd-workshop.zip
   unzip polymermd-workshop.zip
   cd polymermd-workshop-main

   # OR using curl
   curl -L https://github.com/hargu978/polymermd-workshop/archive/refs/heads/main.zip -o polymermd-workshop.zip
   unzip polymermd-workshop.zip
   cd polymermd-workshop-main
   ```

2. Ensure the script has execute permissions:
   ```bash
   chmod +x setup_conda_env.sh
   ```

3. If an old or incorrect environment with the name `polymer_md` exists, deactivate and delete it:
   ```bash
   conda deactivate  # Deactivate the current environment (if any)
   conda env remove -n polymer_md  # Delete the old environment
   ```

4. Run the script:
   ```bash
   ./setup_conda_env.sh
   ```

This script will:
- Check if Conda is installed, and install Miniconda if necessary.
- Create the Conda environment using the `environment.yml` file.
- Activate the environment and source AmberTools.

> **Note:** Ensure the `setup_conda_env.sh` script and `environment.yml` file are in the same directory.

---

## Step 1: Install Conda

### For Linux or macOS:
1. Download the Miniconda installer:
   ```bash
   # For Linux
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

   # For macOS
   curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
   ```
   > **Estimated time:** ~1-3 minutes (depending on network speed)  
   > **Minimum disk space:** ~100 MB for the installer

2. Run the installer:
   ```bash
   bash Miniconda3-latest-<OS>-x86_64.sh  # Replace <OS> with Linux or MacOSX
   ```
   > **Estimated time:** ~2-5 minutes  
   > **Minimum disk space:** ~400 MB for installation

3. Follow the prompts to complete the installation.

4. Delete the installer file:
   ```bash
   rm Miniconda3-latest-<OS>-x86_64.sh
   ```
   > **Estimated time:** ~1 second

5. Activate Conda:
   ```bash
   source ~/.bashrc
   ```
   > **Estimated time:** ~1 second

---

## Step 2: Create the Conda Environment

1. Ensure the `environment.yml` file is in the project root directory:
   ```yaml
   name: polymer_md
   channels:
     - conda-forge
     - dacase
   dependencies:
     - python=3.12
     - ambertools-dac=25     # AmberTools (Linux/macOS via dacase)
     - gromacs
     - parmed
     - openbabel
     - pip
     - pip:
         - nglview
         - jupyter
   ```

2. Create the environment:
   ```bash
   conda env create -f environment.yml
   ```
   > **Estimated time:** ~2-10 minutes (depending on the environment complexity)  
   > **Minimum disk space:** ~1 GB (depending on the packages in `environment.yml`)

3. Activate the environment:
   ```bash
   conda activate polymer_md
   ```
   > **Estimated time:** ~1 second

4. Source the AmberClassic environment:
   ```bash
   source $CONDA_PREFIX/AmberClassic.sh
   ```
   > **Estimated time:** ~1 second  
   > **Minimum disk space:** AmberClassic installation size (if not already installed)

---

## Step 3: Start Jupyter Lab

1. Verify the installation of core tools:
   ```bash
   gmx --version           # GROMACS
   antechamber -h          # AmberClassic / Antechamber
   parmchk2 -h             # Parmchk2
   tleap -h                # tleap (Amber)
   obabel -V               # Open Babel
   jupyter --version       # Jupyter
   ```
   > **Estimated time:** ~1-2 minutes (to verify all tools)

2. Start Jupyter Lab:
   ```bash
   jupyter lab --ip 0.0.0.0 --no-browser
   ```
   > **Estimated time:** ~5-10 seconds

3. Open the URL printed in the terminal to access Jupyter Lab.

---

## Notes

- If any tool is missing, install it manually:
  ```bash
  conda install -c conda-forge gromacs parmed openbabel
  conda install dacase::ambertools-dac=25
  pip install nglview jupyter matplotlib
  ```
  > **Estimated time:** ~2-5 minutes (depending on the missing tools)  
  > **Minimum disk space:** ~500 MB - 1 GB (depending on the tools)

- Refer to the following for more information:
  - [Jupyter Notebook Basics](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Notebook%20Basics.html)
  - [Jupyter Lab Interface](https://jupyterlab.readthedocs.io/en/stable/user/interface.html)

---

## Day 1: Notebook & Example Commands

### Purpose
Demonstrate a compact AmberTools workflow:

1. Convert SMILES → 3D PDB (OpenBabel)
2. Run antechamber to assign GAFF atom types & AM1-BCC charges
3. Run parmchk2 to generate missing force-field terms (.frcmod)
4. Use tleap to create prmtop and inpcrd files

### Example Commands
```bash
# 1. SMILES -> 3D PDB (OpenBabel)
obabel -:"CCO" -O ethanol.pdb --gen3d
# Estimated time: ~5 seconds

# 2. Antechamber: generate mol2 and AM1-BCC charges
antechamber -i ethanol.pdb -fi pdb -o ethanol.mol2 -fo mol2 -c bcc -s 2
# Estimated time: ~10-30 seconds

# 3. Parmchk2: create frcmod
parmchk2 -i ethanol.mol2 -f mol2 -o ethanol.frcmod
# Estimated time: ~5 seconds

# 4. tleap: build prmtop/inpcrd
cat > tleap_ethanol.in << 'EOF'
source leaprc.gaff
ETH = loadmol2 ethanol.mol2
loadamberparams ethanol.frcmod
saveamberparm ETH ethanol.prmtop ethanol.inpcrd
quit
EOF

tleap -f tleap_ethanol.in
# Estimated time: ~5-10 seconds
```

The Day-1 notebook contains these steps with explanatory text and cells you can run interactively.