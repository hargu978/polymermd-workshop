#!/bin/bash

# Author: Harish
# Workshop: Polymer MD Workshop
# Description: This script sets up the Conda environment for the Polymer MD Workshop.
# How to run: 
#   1. Ensure this script has execute permissions: chmod +x setup_conda_env.sh
#   2. Run the script: ./setup_conda_env.sh

# Exit on error
set -e

# Check if Conda is installed
if ! command -v conda &> /dev/null; then
  echo "Conda not found. Installing Miniconda..."

  # Detect OS
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    INSTALLER=Miniconda3-latest-Linux-x86_64.sh
    URL=https://repo.anaconda.com/miniconda/$INSTALLER
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    INSTALLER=Miniconda3-latest-MacOSX-x86_64.sh
    URL=https://repo.anaconda.com/miniconda/$INSTALLER
  else
    echo "Unsupported OS: $OSTYPE"
    exit 1
  fi

  # Download and install Miniconda
  # Estimated time: ~2-5 minutes (depending on network speed)
  # Minimum disk space: ~100 MB for installer + ~400 MB for installation
  curl -O $URL
  bash $INSTALLER -b -p $HOME/miniconda
  rm $INSTALLER

  # Initialize Conda
  # Estimated time: ~1 minute
  source "$HOME/miniconda/etc/profile.d/conda.sh"
  conda init
else
  echo "Conda is already installed."
fi

# Create Conda environment
if [ ! -f "environment.yml" ]; then
  echo "Error: environment.yml not found in the current directory."
  exit 1
fi

# Estimated time: ~2-10 minutes (depending on the environment complexity)
# Minimum disk space: ~1 GB (depending on the packages in environment.yml)
conda env create -f environment.yml

# Activate the environment
# Estimated time: ~1 second
conda activate polymer_md

# Source AmberTool25
# Estimated time: ~1 second
# Minimum disk space: AmberTools installation size (if not already installed)
source $CONDA_PREFIX/amber.sh

echo "Conda environment 'polymer_md' is ready."