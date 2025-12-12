# Day 3: Parameterization of Monomers and Polymer Chain Generation

This tutorial demonstrates how to parameterize monomers and generate polymer chains using **AmberTools**. It includes reusable functions to simplify the process for new molecules and provides visualization tools for both monomers and polymers.

---

## Table of Contents

1. [Initialization](#initialization)
2. [Prepare Monomer](#prepare-monomer)
3. [Parameterize Monomer](#parameterize-monomer)
4. [Define Chain, Head, and Tail](#define-chain-head-and-tail)
5. [Generate Polymer Chain](#generate-polymer-chain)
6. [Convert to GROMACS Formats](#convert-to-gromacs-formats)
7. [Visualize Monomer and Polymer](#visualize-monomer-and-polymer)

---

## Initialization

The first step is to set up the environment for the tutorial. This includes:
- Installing required Python packages (`nglview`, `parmed`).
- Setting up the project root directory.
- Creating subdirectories for monomers and polymers.
- Defining reusable functions for running commands, managing directories, and visualization.

Run the initialization cell to set up the environment.

---

## Prepare Monomer

This step converts a SMILES string, PDB, or XYZ file into a 3D molecular structure in MOL2 format.

### Parameters:
- `mol_name`: Name of the molecule.
- `input_type`: Type of input file (`smiles`, `pdb`, or `xyz`).
- `input_data`: SMILES string or path to the input file.

Example:
```python
prepare_monomer(mol_name="PEO", input_type="smiles", input_data="CCOCCOCCOCCOCCOCC")
```

---

## Parameterize Monomer

This step uses `antechamber` to assign GAFF atom types and AM1-BCC charges to the monomer.

### Parameters:
- `mol_name`: Name of the molecule.

Example:
```python
parameterize_monomer(mol_name="PEO")
```

---

## Define Chain, Head, and Tail

This step defines the chain, head, and tail of the monomer for polymerization. It also generates the required `.prepi` files using `prepgen`.

### Parameters:
- `mol_name`: Name of the molecule.
- `head_id`, `tail_id`: Atom indices for the head and tail.
- `head_omit`, `tail_omit`: Atom indices to omit near the head and tail.

Example:
```python
define_chain_head_tail(
    mol_name="PEO",
    head_id="C1",
    tail_id="C10",
    head_omit=["C", "H", "H1", "H2"],
    tail_omit=["C11", "H23", "H24", "H25"]
)
```

---

## Generate Polymer Chain

This step builds a polymer chain using the defined monomer, head, and tail.

### Parameters:
- `n_mono_repeat`: Number of monomers in a repeat unit.
- `n_mono_pol`: Total number of monomers in the polymer.

Example:
```python
n_mono_repeat = 5
n_mono_pol = 25
mol_name = "PEO"

# Generate polymer sequence
repeat = " ".join([mol_name] * (n_mono_pol // n_mono_repeat - 2))
sequence = f"HPT {repeat} TPT"
```

The polymer chain is generated using `tleap`, and the output files include:
- PDB file: `{mol_name}_{n_mono_pol}mer.pdb`
- Topology file: `{mol_name}_{n_mono_pol}mer.prmtop`
- Coordinate file: `{mol_name}_{n_mono_pol}mer.inpcrd`

---

## Convert to GROMACS Formats

This step converts the AMBER topology and coordinate files into GROMACS-compatible formats using `parmed`.

Example:
```python
amber = pmd.load_file(f"{polymer_dir}/{mol_name}_{n_mono_pol}mer.prmtop", f"{polymer_dir}/{mol_name}_{n_mono_pol}mer.inpcrd")
amber.save(f"{polymer_dir}/{mol_name}_{n_mono_pol}mer.gro", overwrite=True)
amber.save(f"{polymer_dir}/topol.top", format="gromacs", overwrite=True)
```

---

## Visualize Monomer and Polymer

### Visualize Monomer
The monomer can be visualized using its MOL2 file. Atom indices are displayed, and the camera is set to `orthographic`.

Example:
```python
visualize_monomer("PEO")
```

### Visualize Polymer
The polymer can be visualized using its PDB file. Atom indices are displayed, and the camera is set to `orthographic`.

Example:
```python
visualize_polymer("PEO", 25)
```

---

## Notes

- Ensure that all required dependencies are installed before running the notebook.
- The `PROJECT_ROOT` directory is set dynamically and used to organize monomer and polymer files.
- The visualization functions use `nglview` for interactive 3D visualization.

--- 

## License

This tutorial is provided under the MIT License. Use it freely for educational and research purposes.
