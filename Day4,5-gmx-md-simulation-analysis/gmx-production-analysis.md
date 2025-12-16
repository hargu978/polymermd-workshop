# Day 5: Polymer+Water+Ions Production Simulation with GROMACS and Analysis

This tutorial demonstrates how to perform a **production molecular dynamics (MD) simulation** of a solvated polymer system using **GROMACS**, and how to analyze the results. The workflow includes:

1. **Production MD Simulation**: 10 ns simulation at constant pressure (1 bar) and temperature (300 K).
2. **Analysis Stage**: Calculation of key properties:
   - Root Mean Squared Displacement (RMSD) of the polymer chain
   - Radius of Gyration
   - Radial Distribution Function (RDF) for Na-Cl and Na-Os
   - Glass Transition Temperature from simulated annealing

Visualization is performed using **nglview**, **MDAnalysis**, and **matplotlib**.

---

## GROMACS Formats and Models

### GROMACS File Formats
- **.gro**: GROMACS coordinate file (atomic positions, box)
- **.top**: Topology file (structure, force field, composition)
- **.tpr**: Binary input file for GROMACS (`gmx grompp`)
- **.edr**: Energy file
- **.trr**: Full-precision trajectory
- **.xtc**: Compressed trajectory
- **.log**: Simulation log

### Models Used
- **Force Field**: AMBER03 with TIP3P water
- **Polymer**: Random copolymer of PEO and PET
- **Water**: SPC/E
- **Ions**: Na+ and Cl-

For more details, see the [GROMACS Lysozyme Tutorial](http://www.mdtutorials.com/gmx/lysozyme/06_equil.html).

---

## Step 0: Initialization

Set up the environment for the tutorial. Install required Python packages, create directories, and define reusable functions.

**Run this step only once when starting the notebook or after restarting the kernel.**

---

## Production Simulations (NPT at 300 K)

**Purpose:** Perform a production MD simulation at constant pressure (1 bar) and temperature (300 K) to study the polymer system's behavior over time.

**Key Parameters:**
- Integrator: Leap-frog MD
- Simulation Time: 10 ns
- Temperature: 300 K

**Example MDP settings:**
```ini
integrator              = md
nsteps                  = 5000000       ; 10 ns
dt                      = 0.002
tcoupl                  = V-rescale
tc-grps                 = System
tau_t                   = 0.1
ref_t                   = 300
pcoupl                  = Parrinello-Rahman
pcoupltype              = isotropic
tau_p                   = 2.0
ref_p                   = 1.0
compressibility         = 4.5e-5
pbc                     = xyz
gen_vel                 = no
```

**Typical GROMACS commands:**
```bash
gmx grompp -f preeq.mdp -c ../em/em.gro -p ../topol.top -o preeq.tpr -maxwarn 2
gmx mdrun -s preeq.tpr -deffnm preeq -v
```

---

## Example SLURM Script for Remote Server

Provide a SLURM script here if running on a cluster (not shown in this summary).

---

## Analysis Stage

**Purpose:** Analyze the results of the production MD simulation to extract key properties of the polymer system.

**Workflow:**
1. Root Mean Squared Displacement (RMSD)
2. Radius of Gyration
3. Radial Distribution Function (RDF)
4. Glass Transition Temperature

---

### 1. Root Mean Squared Displacement (RMSD) of Polymer Chain

**Purpose:** Calculate the RMSD of the polymer chain to analyze its structural stability over time.

**Procedure:**
1. Use `gmx rms` to calculate RMSD.
2. Plot RMSD vs time.

**Example command:**
```bash
gmx rms -s prod.tpr -f prod.xtc -o rmsd.xvg -tu ns
```

---

### 2. Radius of Gyration of Polymer Chain

**Purpose:** Calculate the radius of gyration to analyze polymer compactness.

**Procedure:**
1. Use `gmx gyrate` to calculate radius of gyration.
2. Plot radius of gyration vs time.

**Example command:**
```bash
gmx gyrate -s prod.tpr -f prod.xtc -o gyrate.xvg
```

---

### 3. Radial Distribution Function (RDF)

**Purpose:** Calculate RDF for Na-Cl and Na-Os.

**Procedure:**
1. Use `gmx rdf` to calculate RDF.
2. Plot RDF vs distance.

**Example commands:**
```bash
gmx rdf -f prod.xtc -s prod.tpr -n index.ndx -o rdf_na_cl.xvg -tu nm
gmx rdf -f prod.xtc -s prod.tpr -n index.ndx -o rdf_na_os.xvg -tu nm
```

---

### 4. Glass Transition Temperature (from Annealing Simulations)

**Purpose:** Analyze the glass transition temperature from simulated annealing.

**Procedure:**
1. Extract temperature and density using `gmx energy`.
2. Plot density vs temperature.

**Example command:**
```bash
gmx energy -f annealing.edr -o temp_density.xvg
```

---

## Visualization

Visualize the polymer structure or trajectory using **nglview** and **MDAnalysis**.

**Example Python usage:**
```python
visualize_trajectory("polymer_solv_ions.gro")
```

---

## License

This tutorial is provided under the MIT License. Use it freely for educational and research purposes.
