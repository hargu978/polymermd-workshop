# Polymer MD Workshop

This workshop is organized in collaboration with [MetaChem Academy](https://metachemacademy.com/).

**Recording Playlist:** [YouTube Workshop Recordings](https://www.youtube.com/playlist?list=PLF5klvjYxgkwIBEl7uZSWMMA_8qbP-ln2)

#> All session recordings will appear at this playlist after the workshop is finished. The videos are non-downloadable and will remain available for 1 year.

**Resources Folder:** [Google Drive Resources](https://drive.google.com/drive/folders/1jxVie8VHSBS0qhesHf3twS_QdnXzHvYk?usp=sharing)

This repository contains Jupyter notebooks and scripts for a hands-on workshop on molecular dynamics (MD) simulations of polymers using AmberTools and GROMACS. The workshop is organized into several days, each focusing on a key aspect of polymer simulation, from small molecule parameterization to full MD production and analysis.

**Enjoy the workshop and happy simulating!**

---

## Quick Install & Initial Steps


### Initial Setup (Run Only Once)
1. **Clone or Download the Repository:**
  ```bash
  git clone https://github.com/hargu978/polymermd-workshop.git
  cd polymermd-workshop
  ```
  Or download and unzip from GitHub if you prefer.

2. **Set Up the Conda Environment:**
  ```bash
  chmod +x setup_conda_env.sh
  ./setup_conda_env.sh
  ```
  This script will install Miniconda (if needed), create the `polymer_md` environment, and install all required packages (AmberTools, GROMACS, nglview, etc.).

> **Note:** Steps 1 and 2 only need to be run once per machine or when you want to update/reset the environment.

### Every New Session (Run Every Time You Start Work)

3. **Open a Terminal and Navigate to the Workshop Folder:**
  - On **Windows**, open your Ubuntu (WSL) terminal.
  - On **Linux/MacOS**, open your regular terminal.
  - Navigate to the workshop folder (replace `PATH_TO` with your actual path):
    ```bash
    cd PATH_TO/polymermd-workshop
    ```

4. **Activate the Environment:**
  ```bash
  conda activate polymer_md
  source $CONDA_PREFIX/amber.sh
  ```

5. **Start Jupyter Lab:**
  ```bash
  jupyter lab --ip 0.0.0.0 --no-browser
  ```
  Open the URL printed in the terminal to access the notebooks in your browser.

---

## Workshop Structure & Notebook Overview


The workshop is organized by day, with each day having a dedicated Jupyter notebook in the `Day1,2-Ambertools-solved/`, `Day3-gen-polymer-solved/`, and `Day4,5-gmx-md-simulation-analysis/` folders. Below is a summary of what is covered each day:

**Related Markdown Documentation:**

- [Conda Setup Guide (step-by-step)](conda-setup-guide.md)
- [Polymer parameterization and chain building (Day 3)](Day3-gen-polymer-solved/ambertools-parameterise-polymer.md)
- [GROMACS system preparation and equilibration (Day 4)](Day4,5-gmx-md-simulation-analysis/gmx-system-prep-equilibration.md)
- [GROMACS production and analysis (Day 5)](Day4,5-gmx-md-simulation-analysis/gmx-production-analysis.md)

### **Day 1: Small Molecule Parameterization with AmberTools**
- **Notebook:** `Day1_ambertools_tutorial.ipynb`
- **Folder:** `Day1,2-Ambertools-solved/`
- **Topics:**
  - Converting SMILES to 3D structures (OpenBabel)
  - Assigning GAFF atom types and AM1-BCC charges (antechamber)
  - Generating missing force field terms (parmchk2)
  - Building topology and coordinate files (tleap)
  - Example: Ethanol parameterization and topology generation

### **Day 2: Polymer Monomer Parameterization**
- **Notebook:** `Day1_ambertools_tutorial.ipynb` (continued)
- **Folder:** `Day1,2-Ambertools-solved/monomer/`
- **Topics:**
  - Parameterizing polymer monomers (PEO, PET)
  - Generating force field files for monomers
  - Preparing for polymer chain construction

### **Day 3: Polymer Chain Construction**
- **Notebook:** `Day3_generate_polymerchains_tutorial copy.ipynb`
- **Folder:** `Day3-gen-polymer-solved/`
- **Topics:**
  - Building polymer chains from monomer units
  - Generating random and block copolymers (PEO/PET)
  - Creating GROMACS-compatible topology and coordinate files for polymers

### **Day 4: System Preparation & Equilibration with GROMACS**
- **Notebook:** `Day4_gromacs_formats_tutorial.ipynb`
- **Folder:** `Day4,5-gmx-md-simulation-analysis/`
- **Topics:**
  - Setting up the simulation box and solvating the polymer
  - Adding ions for neutralization
  - Energy minimization and stepwise equilibration (NVT, NPT)
  - Editing topology files for solvent/ions
  - Extracting and visualizing energy terms (temperature, density)

### **Day 5: Production MD & Analysis**
- **Notebook:** `Day5_gmx_prod_analysis_tutorial.ipynb`
- **Folder:** `Day4,5-gmx-md-simulation-analysis/`
- **Topics:**
  - Running production MD simulations (5–10 ns)
  - Analyzing trajectories: RMSD, radius of gyration, RDFs
  - Glass transition temperature analysis via simulated annealing
  - Visualization with nglview, MDAnalysis, matplotlib
  - Example SLURM scripts for HPC job submission

---

## Additional Notes

- All notebooks are designed to be run interactively in Jupyter Lab after activating the `polymer_md` environment.
- Example input/output files are provided in the relevant folders for each day.
- For troubleshooting or manual installation, see the `environment.yml` and `setup_conda_env.sh` scripts.
- [Install WSL Ubuntu (for Windows users)](Install_Wsl_Ubuntu.md)
- For more details on Jupyter, see:
  - [Jupyter Notebook Basics](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Notebook%20Basics.html)
  - [Jupyter Lab Interface](https://jupyterlab.readthedocs.io/en/stable/user/interface.html)


---

**Workshop Author:**

Harish Gudla  
Computational Material Scientist, Compular, Sweden  
[LinkedIn: Harish Gudla](https://www.linkedin.com/in/harish-gudla-260396/)

---
## License

This tutorial is provided under the MIT License. Use it freely for educational and research purposes.